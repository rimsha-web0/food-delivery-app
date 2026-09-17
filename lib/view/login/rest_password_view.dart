import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ Firebase Auth Import
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common/extension.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import '../../common/globs.dart';
import '../../common_widget/round_textfield.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: TColor.primaryText),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              Text(
                "Reset Password",
                style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 15),
              Text(
                "Please enter your email to receive a\npassword reset link directly to your inbox.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 60),
              RoundTextfield(
                hintText: "Your Email",
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              RoundButton(
                  title: "Send Reset Link",
                  onPressed: () {
                    btnSubmit();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // Action Logic
  Future<void> btnSubmit() async {
    // Email validation
    if (txtEmail.text.isEmpty || !txtEmail.text.contains("@")) {
      mdShowAlert(Globs.appName, "Please enter a valid email address", () {});
      return;
    }

    endEditing();

    // Firebase Method Call
    serviceCallFirebaseReset();
  }

  // Real Firebase Reset Method
  void serviceCallFirebaseReset() async {
    Globs.showHUD(); // Loading dikhayein

    try {
      // 🔥 Firebase Official Reset Command
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: txtEmail.text.trim(),
      );

      Globs.hideHUD(); // Loading khatam

      // Success Alert
      mdShowAlert(
          Globs.appName,
          "A password reset link has been sent to ${txtEmail.text}. Please check your email inbox (and spam folder).",
              () {
            // Alert band hone ke baad Login screen par wapas bhej dein
            Navigator.pop(context);
          }
      );

    } on FirebaseAuthException catch (e) {
      Globs.hideHUD();

      // Error Messages handling
      String errorMsg = "Something went wrong. Try again.";
      if (e.code == 'user-not-found') {
        errorMsg = "No user found with this email address.";
      } else if (e.code == 'invalid-email') {
        errorMsg = "The email address is badly formatted.";
      }

      mdShowAlert(Globs.appName, errorMsg, () {});

    } catch (e) {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, e.toString(), () {});
    }
  }
}