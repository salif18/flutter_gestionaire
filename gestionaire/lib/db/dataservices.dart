import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService {
  // final String baseUrl = "https://jsonplaceholder.typicode.com/users";
 final String baseUrlProducts = "http://localhost:3000/produits";
  Future postProduct(Map<String, dynamic> data) async {
    try {
      final response = await http.post(Uri.parse(baseUrlProducts),
      headers: {"Content-Type":"application/json"}, 
      body: jsonEncode(data)
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

  Future getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrlProducts));
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

  Future getOneProduct(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrlProducts/$id'));
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

  Future updateProduct(int id, Map<String, dynamic> data) async {
    try {
      final response = await http.put(Uri.parse('$baseUrlProducts/$id'), body: json.encode(data));
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

  Future removeProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse('baseUrlProducts/$id'));
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }
}
