import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProducts extends StatefulWidget {
  const EditProducts({super.key});

  @override
  State<EditProducts> createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {

  final GlobalKey _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _categrie = TextEditingController();
  final _stocks = TextEditingController();
  final _prixAchat = TextEditingController();
  final _prixVente = TextEditingController();
  final _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 50,
            child: Center(
              child: Text("Modifier produits",
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
                      controller: _name,
                      validator: null,
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
                      controller: _categrie,
                      validator: null,
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
                      validator: null,
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
                      validator: null,
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
                      validator: null,
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
                    child: TextFormField(
                      controller: _date,
                      validator: null,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          hintText: "Date ",
                          hintStyle: GoogleFonts.aBeeZee(
                              fontSize: 18, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.calendar_month_outlined,
                              size: 30)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            minimumSize: const Size(300, 50)),
                        onPressed: () {},
                        icon: const Icon(Icons.save_as_outlined,
                            size: 33, color: Colors.white),
                        label: Text('MODIFIER',
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
    );;
  }
}