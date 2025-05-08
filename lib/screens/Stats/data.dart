// ignore_for_file: avoid_print

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyChartState createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  late Future<List<PieChartSectionData>> categoryExpensesData;

  @override
  void initState() {
    super.initState();
    categoryExpensesData = _getCategoryExpenses();
  }


  Future<List<PieChartSectionData>> _getCategoryExpenses() async {
    List<PieChartSectionData> data = [];
    try {

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('expenses')
          .orderBy('date')
          .get();

      if (snapshot.docs.isEmpty) {
        print("No expenses data found in Firestore.");
        return [];
      }

      print("Snapshot retrieved: ${snapshot.docs.length} documents found");

      Map<String, double> categoryTotals = {};

      for (var doc in snapshot.docs) {
        var expense = doc.data() as Map<String, dynamic>;

        print("Expense Document Data: $expense");


        String? category;
        if (expense['category'] is Map) {
          category = expense['category']['name']; 
        } else {
          category = expense['category'] as String?; 
        }

        double amount = expense['amount']?.toDouble() ?? 0.0;

        if (category == null || amount == 0.0) {
          print("Skipping invalid document: ${doc.id} (category: $category, amount: $amount)");
          continue;
        }

        if (categoryTotals.containsKey(category)) {
          categoryTotals[category] = categoryTotals[category]! + amount;
        } else {
          categoryTotals[category] = amount;
        }
      }

      print("Processed Category Totals: $categoryTotals");

      if (categoryTotals.isEmpty) {
        print("No valid categories found in data.");
        return [];
      }

      categoryTotals.forEach((category, total) {
        data.add(PieChartSectionData(
          value: total,
          color: Colors.primaries[categoryTotals.keys.toList().indexOf(category) % Colors.primaries.length],
          title: "$category\n₹ ${total.toStringAsFixed(2)}",  // Displaying the category name and amount on the slice
          radius: 70, 
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ));
      });

    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PieChartSectionData>>(
      future: categoryExpensesData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        List<PieChartSectionData> chartData = snapshot.data!;

        return SingleChildScrollView(  
          child: Column(
            children: [

              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.6,
                child: PieChart(PieChartData(
                  sections: chartData,
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 50, 
                  sectionsSpace: 4,
                )),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: chartData.map((sectionData) {
                    String category = sectionData.title.split('\n')[0]; 
                    double value = sectionData.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₹ ${value.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
