import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repository_expenses/repository_expenses.dart';
import 'package:repository_expenses/src/entities/category_entity.dart';
import 'package:repository_expenses/src/entities/expense_entity.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  final categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
          .doc(category.categoryID)
          .set(category.toEntity().toDocument());
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      final snapshot = await categoryCollection.get(); // Get all documents in the collection
      return snapshot.docs.map((e) => Category.fromEntity(CategoryEntity.fromDocument(e.data()))).toList();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      await expenseCollection
          .doc(expense.expenseID)
          .set(expense.toEntity().toDocument());
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      final snapshot = await expenseCollection.get(); // Get all documents in the collection
      return snapshot.docs.map((e) => Expense.fromEntity(ExpenseEntity.fromDocument(e.data()))).toList();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      rethrow;
    }
  }
}
