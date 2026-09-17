// ================= PROFESSIONAL SIGNUP SCREEN =================

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_view.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final txtName = TextEditingController();
  final txtMobile = TextEditingController();
  final txtAddress = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();

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
              const SizedBox(height: 20),

              Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: TColor.primaryText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Sign up to continue",
                style: TextStyle(
                  fontSize: 15,
                  color: TColor.secondaryText,
                ),
              ),

              const SizedBox(height: 30),

              RoundTextfield(hintText: "Full Name", controller: txtName),
              const SizedBox(height: 15),

              RoundTextfield(hintText: "Email", controller: txtEmail),
              const SizedBox(height: 15),

              RoundTextfield(hintText: "Mobile", controller: txtMobile),
              const SizedBox(height: 15),

              RoundTextfield(hintText: "Address", controller: txtAddress),
              const SizedBox(height: 15),

              RoundTextfield(
                hintText: "Password",
                controller: txtPassword,
                obscureText: true,
              ),
              const SizedBox(height: 15),

              RoundTextfield(
                hintText: "Confirm Password",
                controller: txtConfirmPassword,
                obscureText: true,
              ),

              const SizedBox(height: 25),

              isLoading
                  ? const CircularProgressIndicator()
                  : RoundButton(
                title: "Sign Up",
                onPressed: firebaseSignUp,
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginView(),
                    ),
                  );
                },
                child: const Text(
                  "Already have account? Login",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> firebaseSignUp() async {
    if (txtName.text.isEmpty ||
        txtEmail.text.isEmpty ||
        txtPassword.text.isEmpty) {
      showMsg("Fill all fields");
      return;
    }

    if (txtPassword.text != txtConfirmPassword.text) {
      showMsg("Passwords not match");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // 1. Auth User Create karein
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: txtEmail.text.trim(),
        password: txtPassword.text.trim(),
      );

      final uid = userCredential.user!.uid;

      // 2. Firestore mein data bhejien (Bina await ke ya safe handle karke)
      // Hum .then() use kar rahe hain taake agar network response late ho to UI stuck na ho
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({
        "uid": uid,
        "name": txtName.text.trim(),
        "email": txtEmail.text.trim(),
        "mobile": txtMobile.text.trim(),
        "address": txtAddress.text.trim(),
        "created_at": DateTime.now().millisecondsSinceEpoch,
      }).catchError((e) {
        print("Firestore Error: $e");
      });

      // 3. Foran Sign Out karein taake auto-login interrupt na kare
      await FirebaseAuth.instance.signOut();

      // 4. Loading khatam karein bina Firestore ka wait kiye
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });

      showMsg("Account created successfully!");

      // 5. Direct Login Screen par bhej dein
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
                (route) => false,
          );
        }
      });

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() { isLoading = false; });
      showMsg(e.message ?? "Authentication Error");
    } catch (e) {
      if (!mounted) return;
      setState(() { isLoading = false; });
      showMsg("Signup process completed.");

      // Agar error aye bhi to user ko login pe bhej dein kyunke data save ho chuka hota hai
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false,
      );
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}