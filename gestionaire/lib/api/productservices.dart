import 'dart:convert';
import 'package:http/http.dart' as http;

//domaine server
String serverDomaine = "http://10.0.2.2:3000";
String productApi = "/produits";
String productUrl = "$serverDomaine$productApi";

class ProductServiceApi {

  //ajouter des produits
  Future postProduct(Map<String, dynamic> data) async {
    try {
      final response = await http.post(Uri.parse(productUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//obtenir les produits
  Future getAllProducts(productsStreamController) async {
    try {
      final response = await http.get(
        Uri.parse(productUrl),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //mettre les donnees de la requette recu dans ce tableau
        productsStreamController.add(data);
      } else {
        return "Erreur de chargement";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//obtenir un produit
  Future getOneProduct(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$productUrl/$id'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return "Produit n'existe pas";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//mettre a jour
  Future updateProduct(int id, Map<String, dynamic> data) async {
    try {
      final response = await http.put(Uri.parse('$productUrl/$id'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(data));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return "produit non mis a jours";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//supprimer un produits
  Future removeProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse('$productUrl/$id'),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return "Erreur de suppression";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }
}
