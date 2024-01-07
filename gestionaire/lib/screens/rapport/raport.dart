import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRapport extends StatelessWidget {
  const MyRapport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
        centerTitle: true, 
        title: Text("Les rappots",style:GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500, color:Colors.black)),
       leading: IconButton(
        onPressed: (){}, 
        icon: const Icon(Icons.arrow_back_ios_new, size:30),
        ),
       ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
           children:[ 
            
           ]
        ),
      )),
    );
  }
}