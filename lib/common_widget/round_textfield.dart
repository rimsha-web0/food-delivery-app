import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class RoundTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;

  const RoundTextfield({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.bgColor,
    this.left,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: bgColor ?? TColor.textfield,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          if (left != null)
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: left!,
            ),
          Expanded(
            child: TextField(
              controller: controller,
              autocorrect: false,
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: TColor.placeholder,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundTitleTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;

  const RoundTitleTextfield({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.bgColor,
    this.left,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: bgColor ?? TColor.textfield,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          if (left != null)
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: left!,
            ),
          Expanded(
            child: Stack(
              children: [
                TextField(
                  controller: controller,
                  autocorrect: false,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: TColor.placeholder,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 5,
                  child: Text(
                    title,
                    style:
                    TextStyle(color: TColor.placeholder, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}