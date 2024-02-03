import 'dart:convert';
import 'package:http/http.dart' as http;

//domaine server
String serverDomaine = "http://10.0.2.2:3000";
String usersAuthApi = "/auth";
String authUrl = "$serverDomaine$usersAuthApi";


class DepensesServicesApi {

  //connecter user
  Future loginUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(Uri.parse(authUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

  //ajouter des depenses
  Future registreUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(Uri.parse(authUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      return json.decode(response.body);
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

//obtenir le profil de user
  Future getProfilUser(profilsStreamController, userId) async {
    try {
      final response = await http.get(
        Uri.parse('$authUrl/profil/$userId'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //mettre les donnees de la requette recu dans ce tableau
        profilsStreamController.add(data);
      } else {
        return "Erreur de chargement";
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }


//supprimer le compte user
  Future removeUsers(int id) async {
    try {
      final response = await http.delete(Uri.parse('$authUrl/$id'),
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