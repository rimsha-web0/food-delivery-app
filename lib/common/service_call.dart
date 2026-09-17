import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // ✅ Context aur Dialogs ke liye zaroori hai
import 'package:food_delivery/common/color_extension.dart'; // ✅ TColor ke liye
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common/locator.dart';
import 'package:http/http.dart' as http;

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);
typedef ResFailure = Future<void> Function(String);

class ServiceCall {
  static final NavigationService navigationService = locator<NavigationService>();
  static Map userPayload = {};

  static Future<void> post(
      Map<String, dynamic> parameter,
      String path, {
        bool isToken = false,
        ResSuccess? withSuccess,
        ResFailure? failure,
      }) async {
    try {
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

      final response = await http.post(Uri.parse(path), body: parameter, headers: headers);

      if (kDebugMode) print(response.body);

      try {
        final jsonObj = json.decode(response.body) as Map<String, dynamic>;
        if (withSuccess != null) await withSuccess(jsonObj);
      } catch (err) {
        if (failure != null) await failure("Invalid response format");
      }
    } catch (err) {
      if (failure != null) await failure(err.toString());
    }
  }

  // ✅ Sahi Logout Function jo Confirmation mangega
  static void logout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User bahar click karke band na kar sake
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Logout",
          style: TextStyle(
              color: TColor.primaryText,
              fontSize: 18,
              fontWeight: FontWeight.w800),
        ),
        content: Text(
          "Are you sure you want to log out of your account?",
          style: TextStyle(color: TColor.secondaryText, fontSize: 14),
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: TColor.secondaryText,
                  fontWeight: FontWeight.w600),
            ),
          ),
          // Okay / Logout Button
          TextButton(
            onPressed: () {
              // 1. Storage me login status false karen
              Globs.udBoolSet(false, Globs.userLogin);

              // 2. Data clear karen
              userPayload = {};

              // 3. Dialog band karen
              Navigator.pop(context);

              navigationService.navigateTo("welcome");
            },
            child: Text(
              "OK",
              style: TextStyle(
                  color: TColor.primary,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}