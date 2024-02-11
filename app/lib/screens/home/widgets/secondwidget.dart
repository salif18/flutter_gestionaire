import 'package:flutter/material.dart';


class VenteGlobalAndBenefice extends StatelessWidget {
  const VenteGlobalAndBenefice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              width: 160,
              height: 110,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 0, 172, 9)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Ventes",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  Text("\$ 15000",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              width: 160,
              height: 110,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Benefice ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  Text("\$ 15000",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
