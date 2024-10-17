import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime dTime = DateTime.now();

  List<String> category = [
    'entertainment',
    'food',
    'home',
    'other',
    'pet',
    'shopping',
    'tech',
    'travel',
  ];

  @override
  void initState() {
    dateController.text = DateFormat('d/M/y, EEE').format(DateTime.now());
    super.initState();
  }

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
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        FontAwesomeIcons.rupeeSign,
                        size: 16.7,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      hintText: "Amount",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        bool isExpended = false;
                        String selectedIcon = '';
                        Color colorCategory = Colors.white;

                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            title: const Text("Create Category"),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    // controller: dateController,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(
                                          Icons.abc,
                                          size: 16.7,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide.none),
                                        hintText: "Name",
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx2) {
                                            return AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ColorPicker(
                                                    pickerColor: colorCategory,
                                                    onColorChanged: (value) {
                                                      setState(() {
                                                        colorCategory = value;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 40,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(ctx2);
                                                        },
                                                        style: TextButton.styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .blueAccent),
                                                        child: const Text(
                                                          "Save Now",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                          ),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    // controller: dateController,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: colorCategory,
                                        prefixIcon: const Icon(
                                          Icons.color_lens,
                                          size: 16.7,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide.none),
                                        hintText: "Color",
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    onTap: () {
                                      setState(() {
                                        isExpended = !isExpended;
                                      });
                                    },
                                    readOnly: true,
                                    // controller: dateController,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        suffixIcon: const Icon(
                                            Icons.arrow_drop_down_outlined),
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.icons,
                                          size: 16.7,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: isExpended
                                                ? const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))
                                                : BorderRadius.circular(15),
                                            borderSide: BorderSide.none),
                                        hintText: "Icon",
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        )),
                                  ),
                                  isExpended
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 5,
                                                  crossAxisSpacing: 5,
                                                ),
                                                itemCount: category.length,
                                                itemBuilder: (context, int i) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedIcon =
                                                            category[i];
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2,
                                                              color: selectedIcon ==
                                                                      category[
                                                                          i]
                                                                  ? Colors
                                                                      .redAccent
                                                                  : Colors
                                                                      .grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/${category[i]}.png'))),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        )
                                      : Container(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: kToolbarHeight,
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.blueAccent),
                                        child: const Text(
                                          "Save Now",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      });
                },
                controller: categoryController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.list,
                      size: 16.7,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline_sharp),
                      iconSize: 20,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    hintText: "Category",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: dTime,
                    firstDate: DateTime.now().add(const Duration(days: -1000)),
                    lastDate: DateTime.now().add(const Duration(days: 1000)),
                  );
                  if (newDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('d/M/y, EEE').format(newDate);
                      dTime = newDate;
                    });
                  }
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
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    child: const Text(
                      "Save Now",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
