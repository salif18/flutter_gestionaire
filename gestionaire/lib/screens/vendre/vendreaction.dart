import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendreActionCart extends StatefulWidget {
  const VendreActionCart({super.key});

  @override
  State<VendreActionCart> createState() => _VendreActionCartState();
}

class _VendreActionCartState extends State<VendreActionCart> {
  final _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Effectuer les ventes",
            style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.purple)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: const [
          Icon(Icons.shopify_rounded, color: Colors.purple, size: 34),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 1),
                    Text("nivea",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    Text("1200", style: GoogleFonts.roboto(fontSize: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove_outlined, size: 30),
                        ),
                        Text("1",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple[400])),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add, size: 30),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.cancel, size: 30),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 1),
                    Text("nivea",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    Text("1200", style: GoogleFonts.roboto(fontSize: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove_outlined, size: 30),
                        ),
                        Text("1",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple[400])),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add, size: 30),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.cancel, size: 30),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(300, 50),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _date,
                                  keyboardType: TextInputType.datetime,
                                ),
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      minimumSize: const Size(300, 50),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(Icons.save,
                                        size: 30, color: Colors.white),
                                    label: Text("Enregistrer la vente",
                                        style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))),
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.calendar_month_rounded,
                      size: 30, color: Colors.white),
                  label: Text("Ajouter une date",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))),
            )
          ],
        ),
      )),
    );
  }
}
