import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'my_order_view.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  // Real professional wording for a Food App
  List<Map<String, String>> aboutTextArr = [
    {
      "title": "Our Mission",
      "detail": "To provide the fastest and most reliable food delivery service, connecting you with your favorite local restaurants at the click of a button."
    },
    {
      "title": "Fresh & Quality Food",
      "detail": "We partner only with top-rated restaurants that maintain the highest standards of hygiene and food quality to ensure a great experience."
    },
    {
      "title": "Real-time Tracking",
      "detail": "Stay updated with our advanced GPS tracking. Know exactly where your food is, from the restaurant kitchen to your doorstep."
    },
    {
      "title": "Secure Payments",
      "detail": "Enjoy multiple safe payment options including Credit/Debit cards, Digital Wallets, and Cash on Delivery with full encryption."
    },
    {
      "title": "24/7 Customer Support",
      "detail": "Our dedicated support team is always available to assist you with your orders, feedback, or any queries you might have."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 46),

            // --- Custom App Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Image.asset("assets/img/btn_back.png", width: 20, height: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "About Us",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyOrderView()));
                    },
                    icon: Image.asset(
                      "assets/img/shopping_cart.png",
                      width: 25,
                      height: 25,
                      color: TColor.primaryText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- Header Image/Logo (Optional but looks pro) ---
            Center(
              child: Image.asset(
                "assets/img/app_logo.png", // Agar logo ho toh
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.fastfood, size: 80, color: TColor.primary),
              ),
            ),

            const SizedBox(height: 20),

            // --- Content List ---
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: aboutTextArr.length,
              itemBuilder: ((context, index) {
                var item = aboutTextArr[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Orange Bullet Point
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: TColor.primary,
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 15),

                      // Text Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"]!,
                              style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["detail"]!,
                              style: TextStyle(
                                  color: TColor.secondaryText,
                                  fontSize: 14,
                                  height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // --- Version Info ---
            Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(color: TColor.secondaryText, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}