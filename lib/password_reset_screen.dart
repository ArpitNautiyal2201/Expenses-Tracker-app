import 'package:flutter/material.dart';
import 'services/authenication.dart' as auth; 
import 'widget/snack_bar.dart'; 

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    setState(() {
      isLoading = true;
    });

    String res = await auth.AuthServices().resetPassword(email: emailController.text);

    setState(() {
      isLoading = false;
    });

    if (res == "success") {
      showSnackBar(context, "Password reset link sent! Check your email.");
      Navigator.pop(context); 
    } else {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Enter your Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: resetPassword,
                      child: const Text("Send Reset Link"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}