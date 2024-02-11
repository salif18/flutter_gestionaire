import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
   Size get preferredSize => const Size.fromHeight(60);
   final dynamic drawerKey;
  const ProductAppBar({super.key, required this.drawerKey});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, 
      elevation: 0, 
      backgroundColor: const Color.fromARGB(255, 117, 36, 141),
      title: Text("Products", 
      style:GoogleFonts.aBeeZee(
        fontSize: 22, 
        fontWeight: FontWeight.w600, 
        color: Colors.white)),
      leading: IconButton( 
        onPressed: (){},
        icon:const Icon(
          Icons.arrow_back_ios_new, 
          size:30,
          color: Colors.white,), 
      ),
      actions: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: (){
              drawerKey.currentState?.openDrawer();
            }, 
            icon: const Icon(Icons.search, size:30, color:Colors.white)
            ),
        )
      ],

    );
  }
}