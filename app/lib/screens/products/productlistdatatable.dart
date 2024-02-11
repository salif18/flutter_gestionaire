// import 'package:flutter/material.dart';
// import 'package:gestionaire/context/cartprovider.dart';
// import 'package:gestionaire/models/products.dart';
// import 'package:gestionaire/screens/addproducts/addnew.dart';
// import 'package:gestionaire/screens/addproducts/editproduct.dart';
// import 'package:gestionaire/screens/products/widgets/product_appbar.dart';
// import 'package:gestionaire/screens/search/search.dart';
// import 'package:gestionaire/screens/vendre/vendreaction.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:badges/badges.dart' as badges;

// class ProductListInDataTable extends StatelessWidget {
//   ProductListInDataTable({super.key});

//   final List<Products> _products = Products.getProducts();
//   final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  

//   @override
//   Widget build(BuildContext context) {
//     final cartData = Provider.of<CartNotifier>(context);
//     void Function(Products, int) addTocart = cartData.addTocart;
//     List<CartItem> cart = cartData.cart;
//     return Scaffold(
//       appBar: ProductAppBar(drawerKey: _drawerKey),
//       key: _drawerKey,
//       drawer: const MySearchWidget(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width, // Largeur maximale de l'écran
//         ),
//             child: DataTable(
//               columns: [
//                 DataColumn(
//                     label: Text(
//                   'Nom',
//                   style: GoogleFonts.roboto(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 )),
//                 DataColumn(
//                     label: Text(
//                   'Catégorie',
//                   style: GoogleFonts.roboto(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 )),
//                 DataColumn(
//                     label: Text(
//                   'Stocks',
//                   style: GoogleFonts.roboto(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 )),
//                 DataColumn(
//                     label: Text(
//                   'Prix de vente',
//                   style: GoogleFonts.roboto(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 )),
//                 DataColumn(
//                     label: Text(
//                   'Actions',
//                   style: GoogleFonts.roboto(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 )),
//               ],
//               rows: _products.map((product) {
//                 return DataRow(cells: [
//                   DataCell(Text(
//                     product.name.toUpperCase(),
//                     style: GoogleFonts.roboto(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   )),
//                   DataCell(Text(
//                     product.categorie,
//                     style: GoogleFonts.roboto(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   )),
//                   DataCell(Text(
//                     "${product.stocks}",
//                     style: GoogleFonts.roboto(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   )),
//                   DataCell(Text(
//                     "${product.prixVente}",
//                     style: GoogleFonts.roboto(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   )),
//                   DataCell(Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           addTocart(product, 1);
//                         },
//                         icon: const Icon(
//                           Icons.monetization_on,
//                           size: 30,
//                           color: Color.fromARGB(255, 243, 170, 11),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           _showEditProductsModal(context);
//                         },
//                         icon: const Icon(
//                           Icons.edit,
//                           size: 30,
//                           color: Colors.greenAccent,
//                         ),
//                       ),
//                     ],
//                   )),
//                 ]);
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//               backgroundColor: Colors.grey[300],
//               onPressed: () {
//                 _showVenteProductsModal(context);
//               },
//               child: cart.isNotEmpty
//                   ? badges.Badge(
//                       badgeStyle: const badges.BadgeStyle(
//                         badgeColor: Colors.blue,
//                       ),
//                       position: badges.BadgePosition.topEnd(top: -26),
//                       badgeContent: Text("${cart.length}",
//                           style: GoogleFonts.roboto(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white)),
//                       child: const Icon(Icons.shopping_cart_outlined,
//                           size: 30, color: Color.fromARGB(255, 29, 27, 27)),
//                     )
//                   : const Icon(Icons.shopping_cart_outlined,
//                       size: 30, color: Color.fromARGB(255, 36, 34, 34))),
//           const SizedBox(height: 20),
//           FloatingActionButton(
//             backgroundColor: const Color.fromARGB(255, 117, 36, 141),
//             onPressed: () {
//               _showAddNewProductsModal(context);
//             },
//             child: const Icon(Icons.add, size: 30, color: Colors.white),
//           ),
//           const SizedBox(height: 40),
//         ],
//       ),
//     );
//   }

//   void _showAddNewProductsModal(BuildContext context) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           height: MediaQuery.of(context).size.height * 0.8,
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: const AddNewProducts(),
//         );
//       },
//     );
//   }

//   void _showVenteProductsModal(BuildContext context) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.8,
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: const VendreActionCart(),
//         );
//       },
//     );
//   }

//   void _showEditProductsModal(BuildContext context) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.8,
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: const EditProducts(),
//         );
//       },
//     );
//   }
// }
