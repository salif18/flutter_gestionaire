import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Rapports extends StatefulWidget {
  @override
  _RapportsState createState() => _RapportsState();
}

class _RapportsState extends State<Rapports> {
  List<dynamic> vendues = [];
  String dateValue = '';
  late List<dynamic> ventesFilter;

  @override
  void initState() {
    super.initState();
    getVente();
  }

  void getVente() async {
    try {
      final response = await http.get(Uri.parse("http://10.0.2.2:3000/ventes"));
      if (response.statusCode == 200) {
        setState(() {
          vendues = json.decode(response.body);
          ventesFilter = vendues
              .where((x) => x['timestamps'].toString().contains(dateValue))
              .toList();
        });
      } else {
        print('Erreur de chargement');
      }
    } catch (err) {
      print('Erreur réseau: $err');
    }
  }

  void handlePrint() {
    // Implémentez votre logique d'impression ici
  }

  int calculQty() {
    List<int> qty = ventesFilter.map<int>((a) => a['qty']).toList();
    int sum = qty.reduce((a, b) => a + b);
    return sum;
  }

  int calculTotal() {
    List<int> prix = ventesFilter
        .map<int>((x) => (x['prixVente'] * x['qty']).toInt())
        .toList();
    int sum = prix.reduce((a, b) => a + b);
    return sum;
  }

  int calculBenefice(List<dynamic> data) {
    int beneficeTotal = 0;
    for (var x in data) {
      int bene = ((x['prixVente'] * x['qty'] / x['qty']) - x['prixAchat']) * x['qty'];
      print(bene);
      beneficeTotal += bene;
    }
    return beneficeTotal;
  }

  String formatDate(String timestamp) {
    // Implémentez votre logique de formatage de date ici
    return timestamp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rapports du'),
              SizedBox(
                width: 200,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      dateValue = value;
                      ventesFilter = vendues
                          .where((x) => x['timestamps'].toString().contains(dateValue))
                          .toList();
                    });
                  },
                ),
              ),
              DataTable(
                columns: [
                  DataColumn(label: Text('NOMS')),
                  DataColumn(label: Text('CATEGORIES')),
                  DataColumn(label: Text('PRIX D\'ACHAT UNITAIRE')),
                  DataColumn(label: Text('PRIX DE VENTE UNITAIRE')),
                  DataColumn(label: Text('QUANTITES')),
                  DataColumn(label: Text('SOMMES')),
                  DataColumn(label: Text('BENEFICES')),
                ],
                rows: ventesFilter.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(Text(item['nom'])),
                      DataCell(Text(item['categories'])),
                      DataCell(Text('${item['prixAchat']} FCFA')),
                      DataCell(Text('${item['prixVente']} FCFA')),
                      DataCell(Text('${item['qty']}')),
                      DataCell(Text('${item['prixVente'] * item['qty']} FCFA')),
                      DataCell(
                        Text(
                          '${((item['prixVente'] * item['qty'] / item['qty']) - item['prixAchat']) * item['qty']} FCFA',
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              Text('NOMBRE DE PRODUITS VENDUS: $calculQty'),
              Text('LA SOMME TOTALE: $calculTotal FCFA'),
              Text('LE BENEFICE TOTAL: $calculBenefice FCFA'),
              Text('Rapports du ${formatDate(ventesFilter[0]['timestamps'])}'),
              ElevatedButton(
                onPressed: handlePrint,
                child: Row(
                  children: [
                    Icon(Icons.print),
                    SizedBox(width: 10),
                    Text('Imprimer'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


