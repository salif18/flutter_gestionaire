import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLineChart extends StatelessWidget {
  const MyLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        // Configurations générales du graphique
        minX: 0,
        maxX: 5,
        minY: 0,
        maxY: 5,
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            // Titre de l'axe des X (en haut)

            axisNameWidget: Container(
              child: Text(
                "Statistiques de la vente",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.green
                ),
              ),
            ),
          ),
          rightTitles:const AxisTitles(
            // Cacher les titres sur l'axe des Y à droite
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      //  backgroundColor: const Color.fromARGB(255, 22, 7, 48), // Couleur de fond du graphique
        lineBarsData: [
          // Configuration de la ligne du graphique
          LineChartBarData(
            isCurved: true, // Courbe la ligne
            barWidth: 4,
           // color: Colors.red, // Largeur de la ligne
            belowBarData: BarAreaData(
              show: true, 
              // color: Colors.teal// Affiche la zone sous la ligne
            ),
            spots:const [
              FlSpot(0, 0), // Point 1
              FlSpot(1, 4), // Point 2
              FlSpot(2, 2), // Point 3
              FlSpot(3, 2), // Point 4
              FlSpot(4, 4), // Point 5
              FlSpot(5, 5), // Point 6
            ],
          ),
        ],
      ),
    );
  }
}
