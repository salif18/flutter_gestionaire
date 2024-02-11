import 'package:flutter/material.dart';
import 'package:gestionaire/screens/home/widgets/linechart.dart';

class MyChart extends StatelessWidget {
  const MyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 250,
      padding: const EdgeInsets.only(right: 30, top: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child:const MyLineChart(),
      
    );
  }
}
