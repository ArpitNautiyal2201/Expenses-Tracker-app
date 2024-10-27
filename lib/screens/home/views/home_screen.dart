import 'package:expenso_cal/screens/Stats/stats.dart';
import 'package:expenso_cal/screens/expenses/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expenso_cal/screens/expenses/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:expenso_cal/screens/expenses/blocs/get_Category/get_category_bloc.dart';
import 'package:expenso_cal/screens/expenses/view/add_expense.dart';
import 'package:expenso_cal/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expenso_cal/screens/home/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_expenses/repository_expenses.dart';

// ignore: camel_case_types
class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

// ignore: camel_case_types
class _homeScreenState extends State<homeScreen> {
  // var pagesData = [
  //   MainScreen(state.expenses),
  //   const StatScreen(),
  // ];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
        builder: (context, state) {
      if (state is GetExpensesSuccess) {
        return Scaffold(
            //appBar: AppBar(),

            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20), bottom: Radius.circular(20)),
              child: BottomNavigationBar(
                fixedColor: Colors.orange,
                backgroundColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                      icon: (Icon(Icons.home)), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: (Icon(Icons.auto_graph_sharp)), label: 'Stats'),
                  // BottomNavigationBarItem(
                  //     icon: (Icon(Icons.info_outline)), label: 'About'),
                ],
                currentIndex: _selectedItem,
                onTap: (setValue) {
                  setState(() {
                    _selectedItem = setValue;
                  });
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Expense? newExpense = await Navigator.push(
                    context,
                    MaterialPageRoute<Expense>(
                        builder: (BuildContext context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      CreateCategoryBloc(FirebaseExpenseRepo()),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      GetCategoiesBloc(FirebaseExpenseRepo())
                                        ..add(GetCategories()),
                                ),
                                BlocProvider(
                                    create: (context) => CreateExpenseBloc(
                                        FirebaseExpenseRepo())),
                              ],
                              child: const AddExpense(),
                            )));
                if (newExpense != null) {
                  setState(() {
                    state.expenses.add(newExpense);
                  });
                }
              },
              shape: const CircleBorder(),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.tertiary,
                    ], transform: const GradientRotation(3.14 / 3))),
                child: const Icon(Icons.add_rounded),
              ),
            ),
            body: _selectedItem == 0
                ? MainScreen(state.expenses)
                : const StatScreen()
            // pagesData[_selectedItem],
            );
      } else {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
