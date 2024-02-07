import 'dart:async';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:gestionaire/api/depenserservices.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DepensesWidgets extends StatefulWidget {
  const DepensesWidgets({Key? key}) : super(key: key);

  @override
  State<DepensesWidgets> createState() => _DepensesWidgetsState();
}

class _DepensesWidgetsState extends State<DepensesWidgets> {
  DepensesServicesApi depensesServicesApi = DepensesServicesApi();
  StreamController depensesStreamController = StreamController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _depenseTypes = TextEditingController();
  final TextEditingController _depenseMontant = TextEditingController();
  DateTime depenseDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    depensesServicesApi.getAllDepenses(depensesStreamController);
  }

  @override
  void dispose() {
    super.dispose();
    depensesStreamController.close();
  }

  void _showAddDepense(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: Text("Enregistrer une dépense",
                          style: GoogleFonts.roboto(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _depenseTypes,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez remplir ce champ";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Type de dépenses",
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      fillColor: Colors.grey[100],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _depenseMontant,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez remplir ce champ";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Montant",
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      fillColor: Colors.grey[100],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeFormField(
                      decoration: InputDecoration(
                        hintText: 'Choisir la date',
                        hintStyle: GoogleFonts.aBeeZee(
                            fontSize: 18, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.calendar_month, size: 30),
                      ),
                      firstDate: DateTime.now().add(const Duration(days: 10)),
                      lastDate: DateTime.now().add(const Duration(days: 40)),
                      initialPickerDateTime:
                          DateTime.now().add(const Duration(days: 20)),
                      onChanged: (DateTime? value) {
                        setState(() {
                          depenseDate = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 50),
                      backgroundColor: const Color.fromARGB(255, 226, 173, 15),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "montants": _depenseMontant.text,
                          "motifs": _depenseTypes.text,
                          "dateAchat": depenseDate.toIso8601String(),
                        };
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Envoi en cours")),
                        );
                        FocusScope.of(context).requestFocus(FocusNode());
                        depensesServicesApi.postDepenses(data);
                      }
                    },
                    icon: const Icon(Icons.save_alt,
                        size: 33, color: Colors.white),
                    label: Text(
                      "Enregistrer",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Les dépenses",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, size: 30),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: StreamBuilder(
                  stream: depensesStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 300.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Erreur: ${snapshot.error}');
                    } else {
                      final List depenses = snapshot.data;
                      return Column(
                        children: depenses.map((depense) {
                          DateTime date = DateTime.parse(depense["timestamps"]);
                          String formattedDate = DateFormat('yyyy-MM-dd').format(date);

                          return Container(
                            height: 100,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      depense["motifs"].toUpperCase(),
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${depense["montants"]}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        depensesServicesApi.removeDepenses(depense);
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        size: 33,
                                        color:Colors.purple
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showAddDepense(context);
            },
            child: const Icon(Icons.add, size: 33),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
