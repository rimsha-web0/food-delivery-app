import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class RecentItemRow extends StatelessWidget {
  final Map<String, dynamic> rObj;
  final VoidCallback onTap;

  const RecentItemRow({super.key, required this.rObj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                rObj["image"]?.toString() ?? "",
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rObj["name"]?.toString() ?? "",
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        rObj["type"]?.toString() ?? "",
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 11),
                      ),
                      Text(" · ",
                          style:
                          TextStyle(color: TColor.primary, fontSize: 11)),
                      Text(
                        rObj["food_type"]?.toString() ?? "",
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset("assets/img/rate.png",
                          width: 10, height: 10),
                      const SizedBox(width: 4),
                      Text(
                        rObj["rate"]?.toString() ?? "",
                        style: TextStyle(color: TColor.primary, fontSize: 11),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "(${rObj["rating"] ?? "0"} Ratings)",
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}