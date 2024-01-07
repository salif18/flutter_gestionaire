import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

@override
Size get preferredSize => const Size.fromHeight(60);
 final dynamic keydrawer;
  const HomeAppBar({super.key, required this.keydrawer});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Dashboard', style: TextStyle(fontSize: 24, color:Colors.white)),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: (){
            keydrawer.currentState!.openDrawer();
          }, 
          icon: const Icon(Icons.sort, size: 33 ,color:Colors.white)),
      ),
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 117, 36, 141).withOpacity(0),
    );
  }
}