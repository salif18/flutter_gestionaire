import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DepensesWidgets extends StatelessWidget {
  const DepensesWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Les depenses",
            style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, size: 30),
        ),
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showAddDepense(context);
            },
            child: const Icon(Icons.add, size: 33),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }

  void _showAddDepense(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Form(
                  key: null,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: Center(
                          child: Text("Enregistrer une depense",
                              style: GoogleFonts.roboto(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: null,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "Type de depenses",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            fillColor: Colors.grey[100],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Montant",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            fillColor: Colors.grey[100],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: null,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            hintText: "Date",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            fillColor: Colors.grey[100],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 50),
                            backgroundColor: Colors.teal,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.save_alt,
                              size: 33, color: Colors.white),
                          label: Text("Enregistrer",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)))
                    ],
                  ),
                ),
              ));
        });
  }
}
