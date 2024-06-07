import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:final_pro/usable/Store/Store.dart';
class CustomChart extends StatefulWidget {
  final List<dynamic> data;
  int month;
  CustomChart({super.key, required this.data, required this.month});

  @override
  State<CustomChart> createState() => _CustomChartState();
}
class _CustomChartState extends State<CustomChart> {
  double totalAmount = 0.0;
  Random random = Random();

  int filterMonth(String argument){
    return int.parse(argument.substring(5,7));
  }
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
             if (filterMonth(item['serviceDate']) == widget.month)
               PieChartSectionData(
                   value: item['amount'].toDouble() + totalAmount / 30 * 100,
                   title: '',
                   color: Color.fromARGB(
                     150,
                     random.nextInt(256),
                     random.nextInt(256),
                     random.nextInt(256)),
                   badgePositionPercentageOffset: 1.5)
         ]
             : [
           PieChartSectionData(
             value: 100,
             color: const Color(0xFFD787FF),
             badgeWidget: null,
             badgePositionPercentageOffset: 1.5,
           ),
         ],
       )
   );
  }
}

class CustomChartYear extends StatefulWidget {
  final List<dynamic> data;
  int year;
  CustomChartYear({super.key, required this.data, required this.year});
  @override
  State<CustomChartYear> createState() => _CustomChartYearState();
}

class _CustomChartYearState extends State<CustomChartYear> {
  double totalAmount = 0.0;
  Random random = Random();
  int filterYear(String argument){
    return int.parse(argument.substring(0,4));
  }
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
              if (filterYear(item['serviceDate']) == widget.year)
                PieChartSectionData(
                    value: item['amount'].toDouble() + totalAmount / 365 * 100,
                    title: '',
                    color: Color.fromARGB(
                        150,
                        random.nextInt(256),
                        random.nextInt(256),
                        random.nextInt(256)),
                    badgePositionPercentageOffset: 1.5)
          ]
              : [
            PieChartSectionData(
              value: 100,
              color: const Color(0xFFD787FF),
              badgeWidget: null,
              title: '',
              badgePositionPercentageOffset: 1.5,
            ),
          ],
        )
    );
  }
}

