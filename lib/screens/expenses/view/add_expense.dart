import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddExpense extends StatelessWidget {
  const AddExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add Expenses",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        FontAwesomeIcons.rupeeSign,
                        size: 16.7,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.list,
                    size: 16.7,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                  hintText: "Category",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                onTap: () => {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), 
                    firstDate: DateTime.now(), 
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  )
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.calendar,
                    size: 16.7,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                  hintText: "Date",
                ),
              ),
              TextButton(onPressed: () {}, child: const Text("Save Now"))
            ],
          ),
        ),
      ),
    );
  }
}
