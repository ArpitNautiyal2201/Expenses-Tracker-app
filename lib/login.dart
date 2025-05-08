import 'package:expenso_cal/app_view.dart';
import 'package:expenso_cal/password_reset_screen.dart';
import 'package:expenso_cal/widget/button.dart';
import 'package:expenso_cal/widget/text_field.dart';
import 'package:flutter/material.dart';

import 'services/authenication.dart' as auth;
import 'package:expenso_cal/signup.dart';
import 'widget/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    String res = await auth.AuthServices().loginUser(
        email: emailController.text, password: passwordController.text);

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
                height: height / 2.7,
                child: Image.asset("images/login.jpeg"),
              ),
              TextFieldInput(
                  textEditingController: emailController,
                  hintText: "Enter your Email",
                  icon: Icons.email),
              TextFieldInput(
                  isPass: true,
                  textEditingController: passwordController,
                  hintText: "Enter your Password",
                  icon: Icons.password),
              Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                          );
                        },
                        child: const Text("Forget Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue)),
                      ),
                    ),
                  ),
              MyButton(onTab: loginUser, text: "Login"),
              SizedBox(
                height: height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an Account?",
                      style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text("Sign Up",
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
