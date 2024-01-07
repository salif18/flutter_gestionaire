import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchWidget extends StatefulWidget {
  const MySearchWidget({super.key});

  @override
  State<MySearchWidget> createState() => _MySearchWidgetState();
}

class _MySearchWidgetState extends State<MySearchWidget> {

  final GlobalKey _searchKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width *0.8,
      child: ListView( 
        children: [ 
          DrawerHeader(
            child: Form(
              key:_searchKey,
              child: TextFormField(
               controller: null, 
               validator: null, 
               decoration: InputDecoration(
                hintText: "Search product", 
                hintStyle: GoogleFonts.aBeeZee(fontSize: 20, ), 
                fillColor: Colors.grey[100], 
                filled: true, 
                suffixIcon: Icon(Icons.search_outlined, size:28, color:Colors.deepPurple[400]), 
                border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(50), 
                )
               ),
              ),
              )
            ), 
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  
                ],
              ),
            )
        ],
      ),
    );
  }
}