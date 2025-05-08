// ignore_for_file: use_build_context_synchronously

import 'package:expenso_cal/login.dart';
import 'package:expenso_cal/screens/home/views/view_all.dart';
// ignore: implementation_imports
import 'package:repository_expenses/src/entities/total_expenses.dart';
import 'package:expenso_cal/services/authenication.dart';
import 'package:expenso_cal/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository_expenses/repository_expenses.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  final List<Expense> expenses;
  const MainScreen(this.expenses, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<Map<String, double>> totalExpensesByCategory;
  String? userName;

  @override
  void initState() {
    super.initState();
    totalExpensesByCategory = FirebaseService().getTotalExpensesByCategory();
    // totalExpenses = FirebaseService().getTotalExpenses();

    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userName = user?.displayName ?? user?.email?.split('@')[0] ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.pinkAccent),
                        ),
                        const Icon(
                          Icons.person_3_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome!",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        Text(userName ?? "User",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ],
                ),
                MyButton(
                  onTab: () async {
                    await AuthServices().signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  text: "Log Out",
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),

            FutureBuilder<Map<String, double>>(
                future: totalExpensesByCategory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final categoryTotals = snapshot.data;

                  if (categoryTotals != null) {
                    // ignore: avoid_print
                    print("Category Total: $categoryTotals");
                  }

                  if (categoryTotals == null || categoryTotals.isEmpty) {
                    return const Text('No data available');
                  }

                  //double totalIncome = categoryTotals['Income'] ?? 0;
                  double totalExpenses = categoryTotals['Total Expenses'] ?? 0;

                  // ignore: avoid_print
                  print("Total Expenses: $totalExpenses");

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFFFF8D6C),
                          Color(0xFF00B2E7),
                          Color(0xFFE064F7),
                        ], transform: GradientRotation(21 / 3)),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                            bottom: Radius.circular(40)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.grey,
                              offset: Offset(5, 5))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Total Expenses",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "₹ ${totalExpenses.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 60,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 15, horizontal: 20),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Container(
                        //             width: 30,
                        //             height: 30,
                        //             decoration: const BoxDecoration(
                        //               color: Colors.blueAccent,
                        //               shape: BoxShape.circle,
                        //             ),
                        //             child: const Center(
                        //               child: Icon(
                        //                 Icons.arrow_downward_rounded,
                        //                 size: 20,
                        //                 color: Color.fromARGB(255, 36, 164, 42),
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(
                        //             width: 7,
                        //           ),
                        //           const Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Income",
                        //                 style: TextStyle(
                        //                   fontSize: 13,
                        //                   color: Colors.white70,
                        //                   fontWeight: FontWeight.w400,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "₹ 0",
                        //                 style: TextStyle(
                        //                   fontSize: 15,
                        //                   color: Colors.white70,
                        //                   fontWeight: FontWeight.w600,
                        //                 ),
                        //               ),
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //             width: 30,
                        //             height: 30,
                        //             decoration: const BoxDecoration(
                        //               color: Colors.blueAccent,
                        //               shape: BoxShape.circle,
                        //             ),
                        //             child: const Center(
                        //               child: Icon(
                        //                 Icons.arrow_upward_rounded,
                        //                 size: 20,
                        //                 color: Colors.red,
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(
                        //             width: 7,
                        //           ),
                        //           Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               const Text(
                        //                 "Expenses",
                        //                 style: TextStyle(
                        //                   fontSize: 13,
                        //                   color: Colors.white70,
                        //                   fontWeight: FontWeight.w400,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "₹ ${totalExpenses.toStringAsFixed(2)}",
                        //                 style: const TextStyle(
                        //                   fontSize: 15,
                        //                   color: Colors.white70,
                        //                   fontWeight: FontWeight.w600,
                        //                 ),
                        //               ),
                        //             ],
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  );
                }),
            // SizedBox(height: 18,),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transaction",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewAllScreen(allExpenses: widget.expenses)),
                    );
                  },
                  child: const Text(
                    "View all",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.expenses.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Color(widget
                                                .expenses[i].category.color),
                                            shape: BoxShape.circle),
                                      ),
                                      Image.asset(
                                        'assets/${widget.expenses[i].category.icon}.png',
                                        scale: 11.2,
                                      ),
                                      // const Icon(Icons.food_bank_rounded,color: Colors.white,)
                                      // transactionsData[i]['Icon'],
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    widget.expenses[i].category.name,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Rs.${widget.expenses[i].amount}.00",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(widget.expenses[i].date),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
