// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repository_expenses/src/entities/expense_entity.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, double>> getTotalExpensesByCategory() async {
    try {

      QuerySnapshot snapshot = await _db.collection('expenses').get();

      Map<String, double> categoryTotals = {};

      double totalExpenses = 0.0;

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        ExpenseEntity expense = ExpenseEntity.fromDocument(data);

        String categoryName = expense.category.name;
        double amount = expense.amount.toDouble();  

        totalExpenses += amount;

        if (categoryTotals.containsKey(categoryName)) {
          categoryTotals[categoryName] = categoryTotals[categoryName]! + amount;
        } else {
          categoryTotals[categoryName] = amount;
        }
      }

      print('Category Totals: $categoryTotals');
      print('Total Expenses: $totalExpenses');

      categoryTotals['Total Expenses'] = totalExpenses;
      
      return categoryTotals;
    } catch (e) {
      print('Error fetching expenses: $e');
      return {'Expenses': 0.0};  
    }
  }
}
