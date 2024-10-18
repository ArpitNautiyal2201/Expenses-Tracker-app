import 'package:repository_expenses/repository_expenses.dart';

abstract class ExpenseRepository {
  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory();
}
