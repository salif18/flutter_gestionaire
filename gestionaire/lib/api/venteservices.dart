import 'dart:convert';
import 'package:http/http.dart' as http;

//domaine server
String serverDomaine = "http://10.0.2.2:3000";
String ventesApi = "/ventes";
String ventesUrl = "$serverDomaine$ventesApi";


class VentesServicesApi {

//obtenir les produits
  Future getAllVentes(ventesStreamController) async {
    try {
      final response = await http.get(
        Uri.parse(ventesUrl),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //mettre les donnees de la requette recu dans ce tableau
        ventesStreamController.add(data);
      } else {
        return "Erreur de chargement";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//obtenir un produit
  Future getStatsVentes(ventesStatsStreamController) async {
    try {
      final response = await http.get(
        Uri.parse('$ventesUrl/statistique'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //mettre les donnees de la requette recu dans ce tableau
        ventesStatsStreamController.add(data);
      } else {
        return "Produit n'existe pas";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//obtenir un le produit les plus vendus
  Future getMostVentes(mostVentesStreamController) async {
    try {
      final response = await http.get(
        Uri.parse('$ventesUrl/most_sold'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
         final data = json.decode(response.body);
        //mettre les donnees de la requette recu dans ce tableau
        mostVentesStreamController.add(data);
      } else {
        return "Produit n'existe pas";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }


//supprimer un produits
  Future removeDepenses(int id) async {
    try {
      final response = await http.delete(Uri.parse('$ventesUrl/$id'),
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