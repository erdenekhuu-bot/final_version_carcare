import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class CustomChart extends StatefulWidget {
  final List<dynamic> data;
  const CustomChart({super.key, required this.data});

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(
        startDegreeOffset: 830,
        sectionsSpace: 0,
        centerSpaceRadius: 70,
        sections: [
          PieChartSectionData(
              value: 100,
              title: '',
              color: const Color(0xFFD787FF),
              badgeWidget: null,
              badgePositionPercentageOffset: 1.5),
        ]));
  }
}
