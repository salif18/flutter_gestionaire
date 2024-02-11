// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestionaire/api/venteservices.dart';
import 'package:gestionaire/context/cartprovider.dart';
import 'package:gestionaire/models/cartitem.dart';
import 'package:gestionaire/models/products.dart';
import 'package:gestionaire/models/productventes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductVendus extends StatefulWidget {
  const ProductVendus({super.key});

  @override
  State<ProductVendus> createState() => _ProductVendusState();
}

class _ProductVendusState extends State<ProductVendus> {

  //tableau de stock des donnee recuperer
  StreamController ventesStreamController = StreamController();
  //appell de la fonction get vente depuis la class 
  final VentesServicesApi api = VentesServicesApi();


  //get vente
  Future<void> getVentes()async{
    try{
      final res = await api.getAllVentes();
      if(res.statusCode == 200){
        List <dynamic> body = json.decode(res.body);
        // List <ProductVenduModel> products = body.map((json)=> ProductVenduModel.fromJson(json)).toList();
        ventesStreamController.add(body);
      } else{
        _showSnackBarError(context, "Erreur");
      }
    }catch(err){
        _showSnackBarError(context, "Erreur");
    }
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
  void initState() {
    super.initState();
    getVentes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartNotifier>(context);
    void Function(CartItem item) cancelStocks =
        cartData.cancelStocks;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Les ventes",
            style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, size: 30),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: StreamBuilder(
            stream: ventesStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 180,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product["nom"].toUpperCase(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  product["categories"],
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  api.removeVentes(
                                      product, cancelStocks);
                                },
                                icon: const Icon(
                                  Icons.backup_sharp,
                                  size: 30,
                                  color: Color.fromARGB(255, 126, 61, 248),
                                  // Color.fromARGB(255, 6, 114, 133)
                                ),
                              ),
                            ],
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
      )),
    );
  }
}
