import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gestionaire/context/cartprovider.dart';
import 'package:gestionaire/screens/addproducts/addnew.dart';
import 'package:gestionaire/screens/addproducts/editproduct.dart';
import 'package:gestionaire/screens/products/widgets/product_appbar.dart';
import 'package:gestionaire/screens/search/search.dart';
import 'package:gestionaire/screens/vendre/vendreaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  StreamController productsStreamController = StreamController();

  final String baseUrlProducts = "http://10.0.2.2:3000/produits";

  Future getAllProducts() async {
    try {
      final res = await http.get(Uri.parse(baseUrlProducts));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        productsStreamController.add(data);
      } else {
        throw Exception("Erreur de chargements des donnees");
      }
    } catch (err) {
      throw Exception("Erreur réseau: $err");
    }
  }

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartNotifier>(context);
    void Function(Map<String, dynamic>, int) addTocart = cartData.addTocart;
    List<CartItem> cart = cartData.cart;
    return Scaffold(
      appBar: ProductAppBar(drawerKey: _drawerKey),
      key: _drawerKey,
      drawer: const MySearchWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: productsStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 300.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    final List products = snapshot.data;
                    return Column(
                      children: products.map((e) {
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
                              Text(
                                e["nom"].toUpperCase(),
                                style: GoogleFonts.roboto(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                e["categories"],
                                style: GoogleFonts.roboto(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${e["stocks"]}",
                                style: GoogleFonts.roboto(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${e["prixVente"]}",
                                style: GoogleFonts.roboto(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      addTocart(e, 1);
                                    },
                                    icon: const Icon(Icons.monetization_on,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 243, 170, 11)),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _showEditProductsModal(context);
                                    },
                                    icon: const Icon(Icons.edit,
                                        size: 30, color: Colors.greenAccent),
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
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.grey[300],
            onPressed: () {
              _showVenteProductsModal(context);
            },
            child: cart.isNotEmpty
                ? badges.Badge(
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: Colors.blue,
                    ),
                    position: badges.BadgePosition.topEnd(top: -26),
                    badgeContent: Text("${cart.length}",
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    child: const Icon(Icons.shopping_cart_outlined,
                        size: 30, color: Color.fromARGB(255, 29, 27, 27)),
                  )
                : const Icon(Icons.shopping_cart_outlined,
                    size: 30, color: Color.fromARGB(255, 36, 34, 34)),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 117, 36, 141),
            onPressed: () {
              _showAddNewProductsModal(context);
            },
            child: const Icon(Icons.add, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _showAddNewProductsModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const AddNewProducts(),
        );
      },
    );
  }

  void _showVenteProductsModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const VendreActionCart(),
        );
      },
    );
  }

  void _showEditProductsModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const EditProducts(),
        );
      },
    );
  }
}
