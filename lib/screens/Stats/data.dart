import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarChart()
    );
  }

  BarChartData mainBarChart(){
    return BarChartData(
      titlesData: const FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false)
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false)
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true,reservedSize: 40,getTitlesWidget: getTiles)
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true)
      )
      )
    );
  }

  Widget getTiles(double value, TitleMeta meta){} 
}