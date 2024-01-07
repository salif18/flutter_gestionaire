import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.white,
      child: PieChart(
        PieChartData(
         centerSpaceRadius: 70,
          centerSpaceColor: Color.fromARGB(255, 117, 0, 0),
          sections: [
            PieChartSectionData(
              value: 20,
              title: "Ventes",
              titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
              showTitle: true,
              radius: 70,
              color:Colors.purple,
            ),
            PieChartSectionData(
              value: 10, 
              title: "Depenses",
              titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
              showTitle: true,
              radius: 70,
              color: Colors.amber,
            ),
            PieChartSectionData(
              value: 15,
              title: "Benefices",
              titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
              showTitle: true,
              radius: 70,
              color: Color.fromARGB(255, 1, 71, 10),
            ),
          ],
        ),
      ),
    );
  }
}
