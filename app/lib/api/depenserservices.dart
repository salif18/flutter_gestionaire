import 'dart:convert';
import 'package:http/http.dart' as http;

//domaine server
String serverDomaine = "http://10.0.2.2:3000";
String depensesApi = "/depenses";
String depensesUrl = "$serverDomaine$depensesApi";


class DepensesServicesApi {

  //ajouter des depenses
  postDepenses(Map<String, dynamic> data) async {
    return await http.post(Uri.parse(depensesUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
  }

//obtenir les produits
 getAllDepenses() async {
    return await http.get(
        Uri.parse(depensesUrl),
        headers: {"Content-Type": "application/json"},
      );
  }


//supprimer un produits
  removeDepenses(depenseSelected) async {
    return await http.delete(Uri.parse('$depensesUrl/${depenseSelected["id"]}'),
          headers: {"Content-Type": "application/json"});
  }
  
}