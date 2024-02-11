import 'package:flutter/material.dart';
import 'package:gestionaire/context/cartprovider.dart';
import 'package:gestionaire/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:gestionaire/context/authprovider.dart';
import 'package:firebase_core/firebase_core.dart';

void main(){
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> AuthNotifier()),
      ChangeNotifierProvider(create: (context) => CartNotifier())
    ],
      child:const MyApp()
      )
  );
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
      home: const Login(),
    );
  }
}
