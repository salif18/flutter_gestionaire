import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:gestionaire/api/venteservices.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProductModel {
  final int id ;
  final String nom;
  final String categories;
  final int stocks;
  final int prixVente;
  final int qty;
  final int prixAchat;

  ProductModel({
    required this.id,
    required this.nom,
    required this.categories,
    required this.stocks,
    required this.prixVente,
    required this.qty,
    required this.prixAchat,
  });
}

class MyRapport extends StatefulWidget {
  const MyRapport({super.key});

  @override
  State<MyRapport> createState() => _MyRapportState();
}

class _MyRapportState extends State<MyRapport> {
  StreamController ventesStreamController = StreamController();
  final VentesServicesApi ventesServicesApi = VentesServicesApi();
  List ventesFilter = [];

  DateTime depenseDate = DateTime.now();
  String formattedDate = "";

  @override
  void initState() {
    super.initState();
    ventesServicesApi.getAllVentes(ventesStreamController);
    
  }

  @override
  void dispose() {
    ventesStreamController.close();
    super.dispose();
  }

  void getVenteFilterDate() async {
    try {
      final response = await http.get(Uri.parse("http://10.0.2.2:3000/ventes"));
      if (response.statusCode == 200) {
        setState(() {
          final vendues = json.decode(response.body);
          DateTime date = DateTime.parse('$depenseDate');
          String formattedDate = DateFormat('yyyy-MM-dd').format(date);
          ventesFilter = vendues
              .where((x) => x['timestamps'] == formattedDate)
              .toList();
          print(ventesFilter);
        });
      } else {
        print('Erreur de chargement');
      }
    } catch (err) {
      print('Erreur réseau: $err');
    }
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

  int calculBenefice(List data) {
    int beneficeTotal = 0;
    for (var x in data) {
      int bene =
          ((x['prixVente'] * x['qty'] / x['qty']) - x['prixAchat']) * x['qty'];
      print(bene);
      beneficeTotal += bene;
    }
    return beneficeTotal;
  }

  String formatDate(String timestamp) {
    // Implémentez votre logique de formatage de date ici
    return timestamp;
  }

  // int quantity = calculQty();
  // int totalAmount = calculTotal();
  // int benefice = calculBenefice(ventesFilter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        centerTitle: true,
        title: Text("Rapports",
            style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 30, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.purple[400],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Nombre de produits vendu",
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          Text("",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Somme totale",
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          Text("",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Benefice global",
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          Text("",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: DateTimeFormField(
                      decoration: InputDecoration(
                        hintText: 'Choisir la date',
                        hintStyle: GoogleFonts.aBeeZee(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Color.fromARGB(255, 240, 38, 38),
                          size: 35,
                        ),
                      ),
                      firstDate: DateTime.now().add(const Duration(days: 10)),
                      lastDate: DateTime.now().add(const Duration(days: 40)),
                      initialPickerDateTime:
                          DateTime.now().add(const Duration(days: 20)),
                      onChanged: (DateTime? value) {
                        if (value != null) {
                          setState(() {
                            depenseDate = value;
                            
                          });
                          getVenteFilterDate();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: StreamBuilder(
                        stream: ventesStreamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 300.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Erreur: ${snapshot.error}');
                          } else {
                            final List productVendus = snapshot.data;
                            return Column(
                              children: productVendus.map((product) {
                                return Container(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                product["nom"].toUpperCase(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                product["categories"],
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${product["qty"]}",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "${product["prixVente"]}",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
