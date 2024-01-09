import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gestionaire/models/products.dart';

class CartItem {
  String id;
  String name;
  String categorie;
  int quantity;
  int prixAchat;
  int prixVente;
  int somme;

  CartItem(this.id, this.name, this.categorie, this.quantity, this.prixAchat,
      this.prixVente, this.somme);
}

class CartNotifier extends ChangeNotifier {
  //declaration variable
  int _total;
  List<CartItem> _cart;
  final List<Products> _products = Products.getProducts();

  //initialisation des variable
  CartNotifier()
      : _cart = [],
        _total = 0;

//add to cart
  void addTocart(Products item, int qty) {
    final existeItem =
        _cart.firstWhereOrNull((lastItem) => lastItem.id == item.id);
    if (existeItem != null) {
      existeItem.quantity += qty;
    } else {
      _cart.add(CartItem(item.id, item.name, item.categorie, qty,
          item.prixAchat, item.prixVente,2000));
    }
    qty =0;
    notifyListeners();
  }

//remove to cart
  void removeTocart(item) {
    int index = _cart.indexOf(item);
    _cart.removeAt(index);
  }

//incrementation
  void increment(CartItem item) {
    if (item.quantity > 0) {
      _cart = _cart
          .map((lastItem) => lastItem.id == item.id
              ? CartItem(
                  lastItem.id,
                  lastItem.name,
                  lastItem.categorie,
                  lastItem.quantity + 1,
                  lastItem.prixAchat,
                  lastItem.prixVente,
                  lastItem.somme)
              : lastItem)
          .toList();
      notifyListeners();
    }
    
  }

//decrementation
  void decrement(CartItem item) {
    if (item.quantity > 0) {
      _cart = _cart
          .map((lastItem) => lastItem.id == item.id
              ? CartItem(
                  lastItem.id,
                  lastItem.name,
                  lastItem.categorie,
                  lastItem.quantity - 1,
                  lastItem.prixAchat,
                  lastItem.prixVente,
                  lastItem.somme)
              : lastItem)
          .toList();
      notifyListeners();
    }
    
  }

//calcule total
  int calculateTotal() {
    _total = _cart.fold(
        0, (acc, product) => acc + product.quantity * product.prixVente);
    return _total;
  }

//calcule stocks
  Future<void> configStocks(CartItem item) async {
    final product = _products.firstWhere((e) => e.id == item.id);
    if (item.quantity > 0 && item.quantity <= product.stocks) {
      product.stocks -= item.quantity;
      //envoie stock dans la base de donne

    }
  }

  //recalcule stocks en cas d'annulation
  Future<void> cancelStocks(CartItem item) async {
    final product = _products.firstWhere((e) => e.id == item.id);
    if (item.quantity > 0 && item.quantity <= product.stocks ||
        item.quantity >= product.stocks) {
      product.stocks += item.quantity;
      //envoie stock dans la base de donne
    }
  }

//obtenir les valeur des vairable
  List<CartItem> get cart => List.from(_cart);
  int get total => _total.toInt();
}
