import 'dart:async';
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
import 'package:gestionaire/api/productservices.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  //tableau des produits recuperer
  StreamController productsStreamController = StreamController();

//obtenir api getAllProducts dans la classe productServcices
  final ProductServiceApi productServiceApi = ProductServiceApi();

  @override
  void initState() {
    super.initState();
    productServiceApi.getAllProducts(productsStreamController);
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: StreamBuilder(
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
                       
                        children: products.map((product) {
                          return Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                             
                              children: [
                                SizedBox(
                                  width: 265,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 170,
                                        child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[ 
                                            Text(
                                        product["nom"].toUpperCase(),
                                        style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      
                                      Text(
                                        product["categories"],
                                        style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                          ]
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 70,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[ 
                                             Text(
                                        "${product["stocks"]}",
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
                                          ]
                                        ),
                                      )
                                     
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        addTocart(product, 1);
                                      },
                                      icon: const Icon(Icons.monetization_on,
                                          size: 30,
                                          color: Color.fromARGB(
                                              255, 243, 170, 11)),
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
