import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
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
                        shape: BoxShape.circle,
                        color: Colors.orangeAccent
                      ),
                    ),
                    const Icon(Icons.person_3_rounded,color: Colors.white,),
                  ],
                ),
                const SizedBox(width: 8,),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      ),  
                    ),
                    Text(
                      "Arpit Nautiyal",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        
                      )
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}