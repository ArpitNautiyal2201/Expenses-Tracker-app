import 'package:expenso_cal/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class My_App_View extends StatelessWidget {
  const My_App_View({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expenses Calculator",
      theme: ThemeData(
          colorScheme: ColorScheme.light(
        surface: Colors.grey.shade100,
        onSurface: Colors.black,
        primary: const Color(0xFF00B2E7),
        secondary: const Color(0xFFE064F7),
        tertiary: const Color(0xFFFF8D6C),
      )),
      home: const homeScreen(),
    );
  }
}
