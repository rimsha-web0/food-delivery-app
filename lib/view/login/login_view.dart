// ================= PROFESSIONAL LOGIN SCREEN =================

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/view/login/rest_password_view.dart';
import '../on_boarding/on_boarding_view.dart';
import 'rest_password_view.dart';
import '../home/home_view.dart';
import 'sing_up_view.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 80),

              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: TColor.primaryText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Login to continue",
                style: TextStyle(
                  fontSize: 15,
                  color: TColor.secondaryText,
                ),
              ),

              const SizedBox(height: 40),

              RoundTextfield(
                hintText: "Email",
                controller: txtEmail,
              ),

              const SizedBox(height: 15),

              RoundTextfield(
                hintText: "Password",
                controller: txtPassword,
                obscureText: true,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPasswordView()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: TColor.primary, // Check karein aapke TColor mein primary defined hai
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              isLoading
                  ? const CircularProgressIndicator()
                  : RoundButton(
                title: "Login",
                onPressed: loginUser,
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignUpView(),
                    ),
                  );
                },
                child: const Text("Create Account"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: txtEmail.text.trim(),
        password: txtPassword.text.trim(),
      );

      if (!mounted) return;

      setState(() => isLoading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnBoardingView(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Failed")),
      );
    }
  }
}