import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionaire/routes.dart';
import 'package:gestionaire/screens/auth/registre.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFieldForms extends StatefulWidget {
  const MyFieldForms({super.key});

  @override
  State<MyFieldForms> createState() => _MyFieldFormsState();
}

class _MyFieldFormsState extends State<MyFieldForms> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final _number = TextEditingController();
  final _password = TextEditingController();

  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                  "Renseigner les informations demander pour vous connecter a votre compte",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 17, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(10),
              height: 80,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _number,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 210, 198, 212),
                  filled: true,
                  hintText: "Votre numero",
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  prefixIcon: const Icon(CupertinoIcons.phone,
                      color: Colors.white, size: 28),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 80,
                child: Stack(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _password,
                      obscureText: _isVisible,
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 210, 198, 212),
                          filled: true,
                          hintText: "Votre mot de passe",
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(CupertinoIcons.lock,
                              color: Colors.white, size: 28),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: Icon(
                                  _isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 28,
                                  color: const Color.fromARGB(255, 117, 6, 161)))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
                onPressed: () {},
                child: Text("Mot de passe oublier",
                    style: GoogleFonts.roboto(fontSize: 18))),
            Container(
              padding: const EdgeInsets.all(10),
              width: 400,
              height: 70,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Routes()));
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.purple[400]),
                  child: Text("Se connecter",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white))),
            ),
            const SizedBox(height: 10),
            Text("Ou",
                style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 37, 1, 51)),
              width: 400,
              child: Row(
                children: [
                  Image.asset('assets/images/google.png',
                      width: 35, height: 35),
                  const SizedBox(width: 15),
                  Text("Continuer avec Google",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 37, 1, 51)),
              width: 400,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/apple.png',
                    width: 35,
                    height: 35,
                  ),
                  const SizedBox(width: 15),
                  Text("Continuer avec Apple",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white))
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Vous n'avez pas de compte ? -",
                  style: GoogleFonts.roboto(fontSize: 18)),
              TextButton(
                     onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const RegistreWidget()
                      ));
                  },
                  child: Text(
                    "Créer",
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[400]),
                  ))
            ]),
            const SizedBox(height: 10)
          ]),
        ),
      ),
    );
  }
}
