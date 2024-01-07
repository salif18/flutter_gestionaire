import 'package:flutter/material.dart';
import 'package:gestionaire/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gestionaire',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const Routes(),
    );
  }
}
