import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class MostPopularCell extends StatelessWidget {
  final Map<String, dynamic> mObj;
  final VoidCallback onTap;

  const MostPopularCell({super.key, required this.mObj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                mObj["image"]?.toString() ?? "",
                width: 220,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mObj["name"]?.toString() ?? "",
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  mObj["type"]?.toString() ?? "",
                  style:
                  TextStyle(color: TColor.secondaryText, fontSize: 12),
                ),
                Text(" · ",
                    style: TextStyle(color: TColor.primary, fontSize: 12)),
                Text(
                  mObj["food_type"]?.toString() ?? "",
                  style:
                  TextStyle(color: TColor.secondaryText, fontSize: 12),
                ),
                const SizedBox(width: 8),
                Image.asset("assets/img/rate.png", width: 10, height: 10),
                const SizedBox(width: 4),
                Text(
                  mObj["rate"]?.toString() ?? "",
                  style: TextStyle(color: TColor.primary, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}