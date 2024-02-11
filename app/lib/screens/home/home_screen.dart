import 'package:flutter/material.dart';
import 'package:gestionaire/drawer.dart';
import 'package:gestionaire/screens/home/widgets/bestsalstock.dart';
import 'package:gestionaire/screens/home/widgets/chart.dart';
import 'package:gestionaire/screens/home/widgets/firstwidget.dart';
import 'package:gestionaire/screens/home/widgets/appbar_home.dart';
import 'package:gestionaire/screens/home/widgets/piecahart.dart';
import 'package:gestionaire/screens/home/widgets/secondwidget.dart';
import 'package:gestionaire/screens/home/widgets/thirstwidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final GlobalKey<ScaffoldState> _keydrawer = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 117, 36, 141),
      key: _keydrawer,
      appBar: HomeAppBar(keydrawer:_keydrawer),
      drawer: const MyDrawer(),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoStockBestSalles(),
              CountAndAchatWidget(),
              VenteGlobalAndBenefice(),
              DepenseBenefice(),
              SizedBox(height: 25),
              MyChart(),
              MyPieChart()
            ],
          ),
        ),
      ),
    );
  }
}
