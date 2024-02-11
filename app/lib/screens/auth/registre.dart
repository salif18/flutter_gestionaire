import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionaire/screens/auth/widgets/filed_registre.dart';
import 'package:gestionaire/screens/auth/widgets/message_top.dart';


class RegistreWidget extends StatefulWidget {
  const RegistreWidget({super.key});

  @override
  State<RegistreWidget> createState() => _RegistreWidgetState();
}

class _RegistreWidgetState extends State<RegistreWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   MessageTopWidget(),
                   SizedBox(height: 10),
                   FieldFormRegistre()
            ],
          ),
        ),
      ),
    );
  }
}