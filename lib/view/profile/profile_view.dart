import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Storage ke liye

import '../../common/color_extension.dart';
import '../../common_widget/round_textfield.dart';
import '../more/my_order_view.dart';
import '../../common/service_call.dart'; // ✅ Logout ke liye

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAddress = TextEditingController();

  String displayName = "Emilia"; // ✅ Default Name

  @override
  void initState() {
    super.initState();
    loadProfileData(); // ✅ Screen khultay hi purana data load karein
  }

  // --- 🟢 DATABASE SE DATA LOAD KERNA ---
  void loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtName.text = prefs.getString("user_name") ?? "";
      txtEmail.text = prefs.getString("user_email") ?? "";
      txtMobile.text = prefs.getString("user_mobile") ?? "";
      txtAddress.text = prefs.getString("user_address") ?? "";
      displayName = txtName.text.isEmpty ? "User" : txtName.text;

      String? imagePath = prefs.getString("user_image");
      if (imagePath != null) {
        image = XFile(imagePath);
      }
    });
  }

  // --- 🔵 DATABASE ME DATA SAVE KERNA ---
  void saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_name", txtName.text);
    await prefs.setString("user_email", txtEmail.text);
    await prefs.setString("user_mobile", txtMobile.text);
    await prefs.setString("user_address", txtAddress.text);

    if (image != null) {
      await prefs.setString("user_image", image!.path);
    }

    setState(() {
      displayName = txtName.text; // ✅ Save dabatay hi name update ho jaye
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Updated Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(height: 46),
              // --- Header ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Profile", style: TextStyle(color: TColor.primaryText, fontSize: 20, fontWeight: FontWeight.w800)),
                    IconButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrderView())),
                      icon: Image.asset("assets/img/shopping_cart.png", width: 25, height: 25),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- 📸 Profile Picture Logic ---
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(color: TColor.placeholder, borderRadius: BorderRadius.circular(50)),
                child: image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(File(image!.path), width: 100, height: 100, fit: BoxFit.cover),
                )
                    : Icon(Icons.person, size: 65, color: TColor.secondaryText),
              ),

              TextButton.icon(
                onPressed: () async {
                  final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
                  if (selectedImage != null) {
                    setState(() {
                      image = selectedImage;
                    });
                  }
                },
                icon: Icon(Icons.edit, color: TColor.primary, size: 12),
                label: Text("Edit Profile", style: TextStyle(color: TColor.primary, fontSize: 12)),
              ),

              // --- 🏷️ Dynamic Name Display ---
              Text(
                "Hi there $displayName!",
                style: TextStyle(color: TColor.primaryText, fontSize: 16, fontWeight: FontWeight.w700),
              ),

              TextButton(
                onPressed: () => ServiceCall.logout(context), // ✅ Jo pehle logout banaya tha
                child: Text("Sign Out", style: TextStyle(color: TColor.secondaryText, fontSize: 11, fontWeight: FontWeight.w500)),
              ),

              const SizedBox(height: 20),

              // --- 📝 Input Fields ---
              _buildTextField("Name", "Enter Name", txtName),
              _buildTextField("Email", "Enter Email", txtEmail, type: TextInputType.emailAddress),

              // Mobile No (Custom Style: Thora Grey/Disabled look)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: "Mobile No",
                  hintText: "Enter Mobile No",
                  controller: txtMobile,
                  keyboardType: TextInputType.phone,
                  // Iska color background me thora change kar sakte hain common widget me
                ),
              ),

              _buildTextField("Address", "Enter Address", txtAddress),

              const SizedBox(height: 20),

              // --- 💾 Save Button ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButton(title: "Save", onPressed: saveProfileData),
              ),
              const SizedBox(height: 20),
            ]),
          ),
        ));
  }

  // Helper Widget taake code saaf rahy
  Widget _buildTextField(String title, String hint, TextEditingController controller, {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: RoundTitleTextfield(
        title: title,
        hintText: hint,
        controller: controller,
        keyboardType: type,
      ),
    );
  }
}