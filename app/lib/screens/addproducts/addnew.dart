// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestionaire/api/productservices.dart';
import 'package:gestionaire/models/products.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_field/date_field.dart';

class AddNewProducts extends StatefulWidget {
  const AddNewProducts({super.key});

  @override
  State<AddNewProducts> createState() => _AddNewProductsState();
}

class _AddNewProductsState extends State<AddNewProducts> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Obtenez l'API getAllProducts dans la classe ProductServiceApi
  final ProductServiceApi api = ProductServiceApi();

  final TextEditingController _nom = TextEditingController();
  final TextEditingController _categories = TextEditingController();
  final TextEditingController _prixAchat = TextEditingController();
  final TextEditingController _prixVente = TextEditingController();
  final TextEditingController _stocks = TextEditingController();
  DateTime selectedDate = DateTime.now();

  _sendProductToServer() async {
    if (_formKey.currentState!.validate()) {
      var data = {
        "nom": _nom.text,
        "categories": _categories.text,
        "prixAchat": _prixAchat.text,
        "prixVente": _prixVente.text,
        "stocks": _stocks.text,
        "dateAchat": selectedDate.toIso8601String()
      };
      try {
        final res = await api.postProduct(data);
        final body = json.decode(res.body);
        if (res.statusCode == 201) {
          _showSnackBarSuccess(context, body.message);
        }
        _showSnackBarSuccess(context, body.message);
      } catch (err) {
        _showSnackBarError(context, "Erreur");
      }

      //envoie vers base de donnee
    }
  }

  void _showSnackBarSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: const Color.fromARGB(255, 54, 244, 86),
          action: SnackBarAction(
              label: "Close",
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              })),
    );
  }

  void _showSnackBarError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          action: SnackBarAction(
              label: "Close",
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 50,
            child: Center(
              child: Text("Ajouter produits",
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.w500)),
            ),
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nom,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Product name",
                          hintStyle: GoogleFonts.aBeeZee(
                              fontSize: 18, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          prefixIcon:
                              const Icon(Icons.storefront_outlined, size: 30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _categories,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Product categorie",
                          hintStyle: GoogleFonts.aBeeZee(
                              fontSize: 18, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          prefixIcon:
                              const Icon(Icons.category_outlined, size: 30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _stocks,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Product stocks",
                          hintStyle: GoogleFonts.aBeeZee(
                              fontSize: 18, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          prefixIcon:
                              const Icon(Icons.stroller_outlined, size: 30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _prixAchat,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Prix d'achat ",
                          hintStyle: GoogleFonts.aBeeZee(
                              fontSize: 18, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.monetization_on_outlined,
                              size: 30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _prixVente,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Prix de vente ",
                          hintStyle: GoogleFonts.aBeeZee(
                              fontSize: 18, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.money, size: 30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeFormField(
                      decoration: InputDecoration(
                          hintText: 'Choisir la date',
                          hintStyle: GoogleFonts.aBeeZee(
                              fontSize: 18, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          prefixIcon:
                              const Icon(Icons.calendar_month, size: 30)),
                      firstDate: DateTime.now().add(const Duration(days: 10)),
                      lastDate: DateTime.now().add(const Duration(days: 40)),
                      initialPickerDateTime:
                          DateTime.now().add(const Duration(days: 20)),
                      onChanged: (DateTime? value) {
                        setState(() {
                          selectedDate = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            minimumSize: const Size(300, 50)),
                        onPressed: _sendProductToServer,
                        icon: const Icon(Icons.save_as_outlined,
                            size: 33, color: Colors.white),
                        label: Text('AJOUTER',
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
