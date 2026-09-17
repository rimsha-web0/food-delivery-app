import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class TabButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;
  final bool isSelected;

  const TabButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon fixed size
            Image.asset(
              icon,
              width: 20,
              height: 20,
              color: isSelected ? TColor.primary : TColor.placeholder,
            ),
            const SizedBox(height: 4),
            // Title text auto-wrap
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? TColor.primary : TColor.placeholder,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}