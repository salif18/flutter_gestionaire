import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gestionaire/screens/depenses/depenses.dart';
import 'package:gestionaire/screens/home/home_screen.dart';
import 'package:gestionaire/screens/products/productlist.dart';
import 'package:gestionaire/screens/rapport/raport.dart';
import 'package:gestionaire/screens/vendus/productvendus.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        ProductList(),
        const ProductVendus(),
        const MyRapport(),
        const DepensesWidgets(),
      ][_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60.0,
        items: const [
          Icon(
            CupertinoIcons.chart_bar_alt_fill,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.stroller_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.money_dollar,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.rectangle_paperclip,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.calculate_outlined,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: const Color.fromARGB(255, 117, 36, 141),
        buttonBackgroundColor: Color.fromARGB(255, 126, 61, 248),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
