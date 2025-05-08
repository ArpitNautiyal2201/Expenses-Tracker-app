import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository_expenses/repository_expenses.dart';

class ViewAllScreen extends StatefulWidget {
  final List<Expense> allExpenses;

  const ViewAllScreen({super.key, required this.allExpenses});

  @override
  // ignore: library_private_types_in_public_api
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

enum SortField { date, category, amount }

class _ViewAllScreenState extends State<ViewAllScreen> {
  bool isAscending = true;
  SortField currentSortField = SortField.date;

  @override
  Widget build(BuildContext context) {
    List<Expense> sortedExpenses = List.from(widget.allExpenses);

    if (currentSortField == SortField.date) {
      sortedExpenses.sort((a, b) =>
          isAscending ? a.date.compareTo(b.date) : b.date.compareTo(a.date));
    } else if (currentSortField == SortField.category) {
      sortedExpenses.sort((a, b) =>
          a.category.name.toLowerCase().compareTo(b.category.name.toLowerCase()));
    } else if (currentSortField == SortField.amount) {
      sortedExpenses.sort((a, b) =>
          isAscending ? a.amount.compareTo(b.amount) : b.amount.compareTo(a.amount));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Transactions"),
        backgroundColor: Colors.blueAccent,
        actions: [
          if (currentSortField == SortField.date || currentSortField == SortField.amount)
            IconButton(
              icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
              onPressed: () {
                setState(() {
                  isAscending = !isAscending;
                });
              },
              tooltip: isAscending ? "Sort Descending" : "Sort Ascending",
            ),
          PopupMenuButton<SortField>(
            onSelected: (SortField selected) {
              setState(() {
                if (currentSortField == selected) {
                  if (selected == SortField.date || selected == SortField.amount) {
                    isAscending = !isAscending;
                  }
                } else {
                  currentSortField = selected;

                  isAscending = true;
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortField>>[
              const PopupMenuItem<SortField>(
                value: SortField.date,
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem<SortField>(
                value: SortField.category,
                child: Text('Sort by Category'),
              ),
              const PopupMenuItem<SortField>(
                value: SortField.amount,
                child: Text('Sort by Amount'),
              ),
            ],
            icon: const Icon(Icons.sort),
            tooltip: "Sort options",
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sortedExpenses.length,
        itemBuilder: (context, index) {
          final expense = sortedExpenses[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(expense.category.color),
                  child: Image.asset(
                    'assets/${expense.category.icon}.png',
                    scale: 11.5,
                  ),
                ),
                title: Text(expense.category.name),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(expense.date)),
                trailing: Text(
                  "₹ ${expense.amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}