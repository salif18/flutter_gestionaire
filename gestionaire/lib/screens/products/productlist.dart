import 'package:flutter/material.dart';
import 'package:gestionaire/context/cartprovider.dart';
import 'package:gestionaire/models/products.dart';
import 'package:gestionaire/screens/addproducts/addnew.dart';
import 'package:gestionaire/screens/products/widgets/product_appbar.dart';
import 'package:gestionaire/screens/search/search.dart';
import 'package:gestionaire/screens/vendre/vendreaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});

  final List<Products> _products = Products.getProducts();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartNotifier>(context);
    void Function(Products ,int ) addTocart = cartData.addTocart;
    return Scaffold(
      appBar: ProductAppBar(drawerKey: _drawerKey),
      key: _drawerKey,
      drawer:const MySearchWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _products.map((product) {
              return Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name.toUpperCase(),
                        style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500)),
                    Text(product.categorie,
                        style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text("${product.stocks}",
                        style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text("${product.prixVente}",
                        style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500)),
                    IconButton(
                      onPressed: (){
                            addTocart(product, 1);
                      }, 
                      icon:const  Icon(
                        Icons.add_shopping_cart_rounded, size: 30, color: Colors.purple),
                        ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 117, 36, 141),
            onPressed: () {
              _showVenteProductsModal(context);
            },
            child: const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white),
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
}
