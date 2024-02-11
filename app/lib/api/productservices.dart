import 'dart:convert';
import 'package:http/http.dart' as http;

//domaine server
String serverDomaine = "http://10.0.2.2:3000";
String productApi = "/produits";
String productUrl = "$serverDomaine$productApi";

class ProductServiceApi {

  //ajouter des produits
 postProduct(data) async {
       return await http.post(Uri.parse(productUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
  }

//obtenir les produits
 getAllProducts() async {
      return await http.get(
        Uri.parse(productUrl),
        headers: {"Content-Type": "application/json"},
      );
  }

//obtenir un produit
  getOneProduct(int id) async {
      return await http.get(
        Uri.parse('$productUrl/$id'),
        headers: {"Content-Type": "application/json"},
      );
  }

//mettre a jour
  updateProduct(int id, Map<String, dynamic> data) async {
   return await http.put(Uri.parse('$productUrl/$id'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(data));
  }

//supprimer un produits
 removeProduct(int id) async {
  return await http.delete(Uri.parse('$productUrl/$id'),
          headers: {"Content-Type": "application/json"});
  }
  
}
