import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repository_expenses/src/entities/expense_entity.dart';
import 'package:repository_expenses/src/entities/category_entity.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, double>> getTotalExpensesByCategory() async {
    try {
      // Fetch all expenses from Firestore
      QuerySnapshot snapshot = await _db.collection('expenses').get();

      // Initialize a map to track total expenses per category
      Map<String, double> categoryTotals = {};
      
      // Initialize a variable to track the total expenses sum
      double totalExpenses = 0.0;

      // Iterate over all expense documents
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Convert the Firestore document to an ExpenseEntity
        ExpenseEntity expense = ExpenseEntity.fromDocument(data);

        // Extract the category name and expense amount
        String categoryName = expense.category.name;
        double amount = expense.amount.toDouble();  // Ensure it's a double

        // Add the expense amount to the total expenses sum
        totalExpenses += amount;

        // Add the expense amount to the corresponding category total
        if (categoryTotals.containsKey(categoryName)) {
          categoryTotals[categoryName] = categoryTotals[categoryName]! + amount;
        } else {
          categoryTotals[categoryName] = amount;
        }
      }

      // Log the totals for debugging
      print('Category Totals: $categoryTotals');
      print('Total Expenses: $totalExpenses');

      // Return the category totals along with the total expenses
      // You can add the total expenses under a special key if needed
      categoryTotals['Total Expenses'] = totalExpenses;
      
      return categoryTotals;
    } catch (e) {
      print('Error fetching expenses: $e');
      return {'Expenses': 0.0};  // Return a default value in case of error
    }
  }
}
