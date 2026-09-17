import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_delivery/view/login/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common/locator.dart';
import 'package:food_delivery/common/service_call.dart';
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common/my_http_overrides.dart';

import 'package:food_delivery/view/on_boarding/startup_view.dart';

SharedPreferences? prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // ✅ must be first

  HttpOverrides.global = MyHttpOverrides();

  setUpLocator();

  prefs = await SharedPreferences.getInstance();

  // safe check
  if (Globs.udValueBool(Globs.userLogin)) {
    ServiceCall.userPayload = Globs.udValue(Globs.userPayload);
  }

  configLoading();

  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: "Metropolis",
      ),

      // ✅ ALWAYS START FROM SPLASH
      home: const StartupView(),

      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case "welcome":
            return MaterialPageRoute(builder: (context) => const WelcomeView()); // WelcomeView ko import lazmi karein
          default:
            return MaterialPageRoute(builder: (context) => const StartupView());
        }
      },
      builder: EasyLoading.init(),
    );
  }
}