import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class MenuItemRow extends StatelessWidget {
  final Map<String, dynamic> mObj;
  final VoidCallback onTap;

  const MenuItemRow({super.key, required this.mObj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              mObj["image"]?.toString() ?? "",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    mObj["name"]?.toString() ?? "",
                    style: TextStyle(
                      color: TColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset("assets/img/rate.png", width: 10, height: 10),
                      const SizedBox(width: 4),
                      Text(
                        mObj["rate"]?.toString() ?? "",
                        style: TextStyle(color: TColor.primary, fontSize: 11),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        mObj["type"]?.toString() ?? "",
                        style: TextStyle(color: TColor.white, fontSize: 11),
                      ),
                      Text(" · ",
                          style:
                          TextStyle(color: TColor.primary, fontSize: 11)),
                      Text(
                        mObj["food_type"]?.toString() ?? "",
                        style: TextStyle(color: TColor.white, fontSize: 12),
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