import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRapport extends StatelessWidget {
  const MyRapport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        centerTitle: true,
        title: Text("Rapports",
            style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 30, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.purple[400],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.date_range, size: 33, color: Colors.red),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 33,
                        )
                      ]),
                ),
                const SizedBox(width: 20)
              ],
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
