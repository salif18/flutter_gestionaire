import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductVendus extends StatelessWidget {
  const ProductVendus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
        centerTitle: true, 
        title: Text("Les ventes",style:GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500, color:Colors.black)),
       leading: IconButton(
        onPressed: (){}, 
        icon: const Icon(Icons.arrow_back_ios_new, size:30),
        ),
       ),
      body:const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        )
        ),
    );
  }
}