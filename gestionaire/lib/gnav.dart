import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class MyGNav extends StatefulWidget {
  const MyGNav({super.key});

  @override
  State<MyGNav> createState() => _MyGNavState();
}

class _MyGNavState extends State<MyGNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GNav(
      selectedIndex: _currentIndex,
      onTabChange: (context) {
        setState(() {
          _currentIndex = _currentIndex;
        });
      },
      color: const Color.fromARGB(255, 255, 255, 255),
      activeColor: Colors.pink,
      rippleColor: const Color.fromARGB(255, 238, 238, 238),
      hoverColor: const Color.fromARGB(255, 238, 238, 238),
      backgroundColor: Colors.purple,
      tabBackgroundColor: Colors.yellow,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      tabs: const [
        GButton(icon: LineIcons.home, text: "home"),
        GButton(
          icon: LineIcons.calculator,
          text: "calculator",
        ),
        GButton(icon: LineIcons.home, text: "home"),
        GButton(
          icon: LineIcons.calculator,
          text: "calculator",
        )
      ],
    );
  }
}
