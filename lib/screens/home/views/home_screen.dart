import 'package:expenso_cal/screens/home/views/main_screen.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),

      bottomNavigationBar: ClipRRect(
        
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(20)
        ),
        child: BottomNavigationBar(
        fixedColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: (Icon(Icons.home)),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: (Icon(Icons.auto_graph_sharp)),
            label: 'Stats'
          ),
          BottomNavigationBarItem(
            icon: (Icon(Icons.info_outline)),
            label: 'About'
          )  
        ]
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
            ],
            transform: const GradientRotation(3.14 / 3)
            )
          ),
          child: const Icon(
            Icons.add_rounded
          ),
        ),
      ),
      body: const MainScreen(),
    );
  }
}