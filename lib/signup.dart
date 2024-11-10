// ignore_for_file: non_constant_identifier_names

import 'package:expenso_cal/app_view.dart';
import 'package:expenso_cal/login.dart';
import 'package:expenso_cal/services/authenication.dart';
import 'package:expenso_cal/widget/snack_bar.dart';
import 'package:flutter/material.dart';

import 'widget/button.dart';
import 'widget/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void SignUpUser() async {
    String res = await AuthServices().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);

    if (res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const My_App_View()));
    } else {
      setState(() {
        isLoading = false;
      });

      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.8,
                child: Image.asset("images/Signup.jpeg"),
              ),
              TextFieldInput(
                  textEditingController: nameController,
                  hintText: "Enter your Name",
                  icon: Icons.person),
              TextFieldInput(
                  textEditingController: emailController,
                  hintText: "Enter your Email",
                  icon: Icons.email),
              TextFieldInput(
                  textEditingController: passwordController,
                  hintText: "Enter your Password",
                  isPass: true,
                  icon: Icons.password),
              MyButton(onTab: SignUpUser, text: "Sign Up"),
              SizedBox(
                height: height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?",
                      style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              )
            ],
          ),
        )));
  }
}
