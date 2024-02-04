import 'dart:convert';
import 'package:http/http.dart' as http;

//domaine server
String serverDomaine = "http://10.0.2.2:3000";
String depensesApi = "/depenses";
String depensesUrl = "$serverDomaine$depensesApi";


class DepensesServicesApi {

  //ajouter des depenses
  Future postDepenses(Map<String, dynamic> data) async {
    try {
      final response = await http.post(Uri.parse(depensesUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//obtenir les produits
  Future getAllDepenses(depensesStreamController) async {
    try {
      final response = await http.get(
        Uri.parse(depensesUrl),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //mettre les donnees de la requette recu dans ce tableau
        depensesStreamController.add(data);
      } else {
        return "Erreur de chargement";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }


//supprimer un produits
  Future removeDepenses(depenseSelected) async {
    try {
      final response = await http.delete(Uri.parse('$depensesUrl/${depenseSelected["id"]}'),
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