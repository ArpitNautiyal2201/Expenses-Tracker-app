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
                    ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.settings_rounded))
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            // SizedBox(height: 18,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFFFF8D6C),
                  
                  Color(0xFF00B2E7),
                  Color(0xFFE064F7),
                ],
            transform: GradientRotation(21 / 3)
            ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                  bottom: Radius.circular(40)
                ),
                
              ),
              child: Column(
                children: [
                  const Text("Total Balance"),
                  const Text("₹ 1000"),

                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.arrow_downward_rounded,size: 20,),
                              
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}