import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

//domaine de server
String serverDomaine = "http://10.0.2.2:3000";

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

  // Vous pouvez appeler getAllProducts() dans le constructeur de la classe.
  CartNotifier()
      : _cart = [],
        _total = 0;

//ajouter produit dans lae panier
  void addTocart(Map<String, dynamic> item, int qty) {
    final existeItem = _cart.isNotEmpty
        ? _cart.firstWhereOrNull((lastItem) => lastItem.id == item["id"])
        : null;
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
    final String baseUrlVendres = "$serverDomaine/ventes";
    try {
      await Future.forEach(_cart, (CartItem e) async {
        final res = await http.post(
          Uri.parse(baseUrlVendres),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": e.id,
            "nom": e.nom,
            "categories": e.categories,
            "prixAchat": e.prixAchat,
            "prixVente": e.prixVente,
            "stocks": e.stocks,
            "qty": e.quantity,
            "timestamps": selectedDate.toIso8601String(),
          }),
        );

        if (res.statusCode == 200) {
          await configStock(e);
          _cart.clear();
        } else {
          throw Exception("erreur");
        }
      });
    } catch (e) {
      throw Exception("erreur $e");
    }
  }

//mis a jour du stock des produits acheter
  Future<void> configStock(CartItem item) async {
    final res = await http.get(Uri.parse('$serverDomaine/produits/${item.id}'));
    if (res.statusCode == 200) {
      final product = json.decode(res.body);
      final Map<String, dynamic> prod = product[0];
      if (item.quantity > 0 && item.quantity <= prod['stocks']) {
        prod['stocks'] -= item.quantity;
        try {
          await http.put(
            Uri.parse('$serverDomaine/produits/newStock/${prod['id']}'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"stocks": prod['stocks']}),
          );
        } catch (err) {
          throw Exception(err);
        }
      } else {
        print('Stock insuffisant pour le produit ${item.nom}');
      }
    } else {
      throw Exception("Erreur de chargements");
    }
  }

//mis a jour de stock des produit retourner
  Future<void> cancelStocks(CartItem item) async {
    //final product = _products.firstWhere((e) => e["id"] == item.id);
    final res = await http.get(Uri.parse('$serverDomaine/produits/${item.id}'));
    if (res.statusCode == 200) {
      final product = json.decode(res.body);
      final Map<String, dynamic> prod = product[0];
      if (item.quantity > 0 && item.quantity <= prod["stocks"] ||
          item.quantity >= prod["stocks"]) {
        prod["stocks"] += item.quantity;
        
        // Envoie de la mise à jour du stock à la base de données
        try {
          await http.put(
            Uri.parse('$serverDomaine/produits/newStock/${prod['id']}'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"stocks": prod['stocks']}),
          );
        } catch (err) {
          throw Exception(err);
        }
      }
    }
  }

  List<CartItem> get cart => List.from(_cart);
  int get total => _total.toInt();
}
