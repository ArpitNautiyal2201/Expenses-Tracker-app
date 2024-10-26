import 'package:expenso_cal/screens/expenses/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repository_expenses/repository_expenses.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context) {
  List<String> category1 = [
    'entertainment',
    'food',
    'home',
    'other',
    'pet',
    'shopping',
    'tech',
    'travel',
  ];

  return showDialog(
      context: context,
      builder: (ctx) {
        bool isExpended = false;
        String selectedIcon = '';
        Color colorCategory = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
        Category category = Category.empty;

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(builder: (ctx, setState) {
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx, context);
                } else if (state is CreateCategoryLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                title: const Text("Create Category"),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: categoryNameController,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.abc,
                              size: 16.7,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
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
                        controller: categoryColorController,
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
                                                    Colors.blueAccent),
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
                                borderRadius: BorderRadius.circular(50),
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
                        controller: categoryIconController,
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
                            suffixIcon:
                                const Icon(Icons.arrow_drop_down_outlined),
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.icons,
                              size: 16.7,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: isExpended
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))
                                    : BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                            hintText: "Icon",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      isExpended
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
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
                                    itemCount: category1.length,
                                    itemBuilder: (context, int i) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIcon = category1[i];
                                          });
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: selectedIcon ==
                                                          category1[i]
                                                      ? Colors.redAccent
                                                      : Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/${category1[i]}.png'))),
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
                        child: isLoading == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                  category.categoryID = const Uuid().v1();
                                  category.name = categoryNameController.text;
                                  category.icon = selectedIcon;
                                  category.color = colorCategory.value;
                                  });
                                  
                                  context
                                      .read<CreateCategoryBloc>()
                                      .add(CreateCategory(category));
                                  // Navigator.pop(context);
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
              ),
            );
          }),
        );
      });
}
