import 'package:expenso_cal/screens/Stats/data.dart';
import 'package:flutter/material.dart';


class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Transaction",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                // color: Colors.red,
                 child: MyChart()
                // BarChart(
                //   BarChartData()
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}