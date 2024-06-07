import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:final_pro/usable/Store/Store.dart';
class CustomChart extends StatefulWidget {
  final List<dynamic> data;
  CustomChart({super.key, required this.data});

  @override
  State<CustomChart> createState() => _CustomChartState();
}
class _CustomChartState extends State<CustomChart> {
  double totalAmount = 0.0;
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    totalAmount = 0.0;
    for (var item in widget.data) {
      totalAmount += item['amount'];
      Store.amount=totalAmount;
    }

   return PieChart(
     PieChartData(
       startDegreeOffset: 830,
       sectionsSpace: 0,
       centerSpaceRadius: 70,
       sections: widget.data.isNotEmpty
           ? [
         for (var item in widget.data)
           PieChartSectionData(
               value: item['amount'].toDouble() / totalAmount,
               title: '',
               color: Color.fromARGB(150, random.nextInt(256),
                   random.nextInt(256), random.nextInt(256)),
               badgePositionPercentageOffset: 1.5),

       ] : [
         PieChartSectionData(
             value: 100,
             color: const Color(0xFFD787FF),
             badgeWidget: null,
             badgePositionPercentageOffset: 1.5),
       ],
     ),
   );
  }
}

