import 'package:flutter/material.dart';
import 'package:gestionaire/screens/auth/widgets/field_login.dart';
import 'package:gestionaire/screens/auth/widgets/message_top.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          // Color.fromARGB(255, 37, 1, 51),
          Color.fromARGB(255, 123, 3, 145),
          Color.fromARGB(255, 28, 1, 39),
        ], 
        begin: Alignment.topCenter, 
        end: Alignment.bottomCenter
        ),
      ),
        child: const SingleChildScrollView(
            child: Column(    
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   MessageTopWidget(),
                   SizedBox(height: 10),
                   MyFieldForms()
            ],
          ),
        ),
      ),
    );
  }
}
