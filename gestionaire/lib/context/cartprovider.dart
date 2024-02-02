import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class CartItem {
  int id;
  String nom;
  String categories;
  int quantity;
  int prixAchat;
  int prixVente;
  int stocks;
  int somme;

  CartItem(this.id, this.nom, this.categories, this.quantity, this.prixAchat,
      this.prixVente, this.stocks, this.somme);
}

class CartNotifier extends ChangeNotifier {
  int _total;
  List<CartItem> _cart;
  final List<Map<String, dynamic>> _products = [];

  // Vous pouvez appeler getAllProducts() dans le constructeur de la classe.
  CartNotifier() : _cart = [], _total = 0 {
    getAllProducts().then((_) {
    print(_products);
  });
  }

//obtenir tous les produits
  Future<void> getAllProducts() async {
    const String baseUrlProducts = "http://10.0.2.2:3000/produits";
    try {
      final res = await http.get(Uri.parse(baseUrlProducts));
      final data = json.decode(res.body);
      if (data is List) {
        _products.addAll(List<Map<String, dynamic>>.from(data));
      } else {
        throw Exception("La réponse n'est pas une liste JSON");
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//ajouter produit dans lae panier
  void addTocart(Map<String, dynamic> item, int qty) {
    final existeItem = _cart.isNotEmpty ?
        _cart.firstWhereOrNull((lastItem) => lastItem.id == item["id"]) : null;
    if (existeItem != null) {
      existeItem.quantity += qty;
    } else {
      _cart.add(CartItem(item["id"], item["nom"], item["categories"], qty,
          item["prixAchat"], item["prixVente"], item["stocks"], 2000));
    }
    qty = 0;
    notifyListeners();
  }

//supprimer produit de panier
  void removeTocart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

//incrementer produit dans le panier
  void increment(CartItem item) {
    if (item.quantity > 0) {
      _cart = _cart
          .map((lastItem) => lastItem.id == item.id
              ? CartItem(
                  lastItem.id,
                  lastItem.nom,
                  lastItem.categories,
                  lastItem.quantity + 1,
                  lastItem.prixAchat,
                  lastItem.prixVente,
                  lastItem.stocks,
                  lastItem.somme)
              : lastItem)
          .toList();
      notifyListeners();
    }
  }

//decrementer produit de panier
  void decrement(CartItem item) {
    if (item.quantity > 0) {
      _cart = _cart
          .map((lastItem) => lastItem.id == item.id
              ? CartItem(
                  lastItem.id,
                  lastItem.nom,
                  lastItem.categories,
                  lastItem.quantity - 1,
                  lastItem.prixAchat,
                  lastItem.prixVente,
                  lastItem.stocks,
                  lastItem.somme)
              : lastItem)
          .toList();
      notifyListeners();
    }
  }

//calcule total de panier
  int calculateTotal() {
    _total = _cart.fold(
        0, (acc, product) => acc + product.quantity * product.prixVente);
    return _total;
  }


//envoyer les produits acheter dans la base 
 Future<void> sendCart(DateTime selectedDate) async {
  const String baseUrlVendres = "http://10.0.2.2:3000/ventes";
  try {
    await Future.forEach(_cart, (CartItem e) async {
      final Map<String, dynamic> requestBody = {
        "id": e.id,
        "nom": e.nom,
        "categories": e.categories,
        "prixAchat": e.prixAchat,
        "prixVente": e.prixVente,
        "stocks": e.stocks,
        "qty": e.quantity,
        "timestamps": selectedDate.toIso8601String(),
      };

      final res = await http.post(
        Uri.parse(baseUrlVendres),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (res.statusCode == 200) {
        await configStock(e);
      } else {
        print("erreur");
      }
    });
  } catch (e) {
    print("erreur $e");
  }
}



//mis a jour du stock des produits acheter
  Future<void> configStock(CartItem item) async {
    // final product = _products.firstWhere((x) => x['id'] == item.id);
final res = await http.get(Uri.parse('http://10.0.2.2:3000/produits/${item.id}'));
if(res.statusCode == 200){
final product = json.decode(res.body);
final Map<String ,dynamic> prod = product[0];
    if (item.quantity > 0 && item.quantity <= prod['stocks']) {
      prod['stocks'] -= item.quantity;
      try {
        await http.put(
          Uri.parse('http://10.0.2.2:3000/produits/newStock/${prod['id']}'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"stocks":prod['stocks']}),
        );
      } catch (err) {
        print(err);
      }
  }
    } else {
      print('Stock insuffisant pour le produit ${item.nom}');
    }
  }

//mis a jour de stock des produit retourner
  Future<void> cancelStocks(CartItem item) async {
    //final product = _products.firstWhere((e) => e["id"] == item.id);
    final res = await http.get(Uri.parse('http://10.0.2.2:3000/produits/${item.id}'));
    if(res.statusCode == 200){
      final product = json.decode(res.body);
      final Map<String ,dynamic> prod = product[0];
    if (item.quantity > 0 && item.quantity <= prod["stocks"] ||
        item.quantity >= prod["stocks"]) {
      prod["stocks"] += item.quantity;
      
      // Envoie de la mise à jour du stock à la base de données
      try {
        await http.put(
          Uri.parse('http://10.0.2.2:3000/produits/newStock/${prod['id']}'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"stocks":prod['stocks']}),
        );
      } catch (err) {
        print(err);
      }
    }
    }
  }

  List<CartItem> get cart => List.from(_cart);
  int get total => _total.toInt();
}
