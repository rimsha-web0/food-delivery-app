import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class PopularRestaurantRow extends StatelessWidget {
  final Map<String, dynamic> pObj;
  final VoidCallback onTap;

  const PopularRestaurantRow({
    super.key,
    required this.pObj,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              pObj["image"]?.toString() ?? "",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pObj["name"]?.toString() ?? "",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset("assets/img/rate.png",
                          width: 10, height: 10),
                      const SizedBox(width: 4),
                      Text(
                        pObj["rate"]?.toString() ?? "",
                        style: TextStyle(color: TColor.primary, fontSize: 11),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "(${pObj["rating"] ?? "0"} Ratings)",
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 11),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        pObj["type"]?.toString() ?? "",
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 11),
                      ),
                      Text(" · ",
                          style:
                          TextStyle(color: TColor.primary, fontSize: 11)),
                      Text(
                        pObj["food_type"]?.toString() ?? "",
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 12),
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