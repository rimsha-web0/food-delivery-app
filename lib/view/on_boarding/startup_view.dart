import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/common/globs.dart';

// ✅ Zaroori Imports
import '../main_tabview/main_tabview.dart'; // Jahan aapki bottom bar ka code hai
import '../login/welcome_view.dart'; // Ya LoginView jo bhi aapka pehla page hai

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();

    // Splash delay ke baad login check karein
    Future.delayed(const Duration(seconds: 3), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    // 1. Firebase user status check karein
    try {
      await FirebaseAuth.instance.currentUser?.reload();
    } catch (e) {
      await FirebaseAuth.instance.signOut();
    }

    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    // 2. Logic: User login hai ya nahi
    // Globs wala check bhi saath laga rahi hun taake confirm ho
    if (user != null && Globs.udValueBool(Globs.userLogin)) {
      // 🔥 CRITICAL FIX: Direct HomeView par nahi jana!
      // Hamesha MainTabView par jana hai taake Bottom Bar show ho.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainTabView(),
        ),
      );
    } else {
      // Agar login nahi hai toh Welcome ya Login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const WelcomeView(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Background Image (Correct Fit)
          Image.asset(
            "assets/img/splash_bg.png",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),

          // 2. Logo Container (Size increased and Centered)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/img/app_logo.png",
              width: media.width * 0.6, // 🔥 BIGGER LOGO: 60% of screen width (Increased from 0.4)
              fit: BoxFit.contain,
            ),
          ),

          // 3. Loading Indicator at bottom (Positioned perfectly)
          const Positioned(
            bottom: 50,
            child: CircularProgressIndicator(
              color: Color(0xFFFC6011), // Professional orange primary color
              strokeWidth: 4, // Bold loader
            ),
          )
        ],
      ),
    );
  }
}