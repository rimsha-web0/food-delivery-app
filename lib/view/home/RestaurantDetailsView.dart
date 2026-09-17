import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/color_extension.dart';

class RestaurantDetailsView extends StatelessWidget {
  final Map pObj;
  const RestaurantDetailsView({super.key, required this.pObj});

  // --- 🛒 FIREBASE ADD TO CART LOGIC ---
  Future<void> addToFirebaseCart(BuildContext context, Map item, int qty) async {
    try {
      // 1. Current user ki ID lena
      String uid = FirebaseAuth.instance.currentUser?.uid ?? "";

      if (uid.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please login to add items to cart!")),
        );
        return;
      }

      // 2. Firestore mein "users" -> "uid" -> "cart" collection mein data dalna
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("cart")
          .add({
        "name": item["name"],
        "price": item["price"],
        "qty": qty,
        "image": item["image"],
        "restaurant_name": pObj["name"],
        "created_at": FieldValue.serverTimestamp(), // Exact time ke liye
      });

      Navigator.pop(context); // Bottom sheet band karein
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${item["name"]} added to cart successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  // --- 🛒 ADD TO CART BOTTOM SHEET UI ---
  void _showAddToCart(BuildContext context, Map item) {
    int qty = 1;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item["name"],
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Text("Rs. ${item["price"]}",
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (qty > 1) setState(() => qty--);
                        },
                        icon: Icon(Icons.remove_circle_outline,
                            color: TColor.primary, size: 35)),
                    const SizedBox(width: 20),
                    Text("$qty",
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 22,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(width: 20),
                    IconButton(
                        onPressed: () {
                          setState(() => qty++);
                        },
                        icon: Icon(Icons.add_circle_outline,
                            color: TColor.primary, size: 35)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColor.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () {
                    // Firebase function call yahan hogi
                    addToFirebaseCart(context, item, qty);
                  },
                  child: const Text("Add to Cart",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List getMenu() {
      String resName = pObj["name"].toString();
      if (resName == "Minute by tuk tuk") {
        return [
          {"name": "Tuk Tuk Special Burger", "price": "750", "image": "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=500"},
          {"name": "Spicy Peri Peri Fries", "price": "350", "image": "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?q=80&w=500"},
          {"name": "Crunchy Sandwich", "price": "600", "image": "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?q=80&w=500"},
        ];
      } else if (resName == "Café de Noir") {
        return [
          {"name": "Iced Black Coffee", "price": "450", "image": "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=500"},
          {"name": "Chocolate Lava Muffin", "price": "400", "image": "https://images.unsplash.com/photo-1582293041079-7814c2f12063?q=80&w=500"},
        ];
      } else {
        return [
          {"name": "Special Dish", "price": "1200", "image": "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=500"},
        ];
      }
    }

    List menuArr = getMenu();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image with Back Button
            Stack(
              children: [
                Image.asset(pObj["image"].toString(), width: double.infinity, height: 250, fit: BoxFit.cover),
                Container(width: double.infinity, height: 250, color: Colors.black.withOpacity(0.25)),
                SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
              ],
            ),

            // Restaurant Info
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pObj["name"], style: TextStyle(color: TColor.primaryText, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: TColor.primary, size: 18),
                      const SizedBox(width: 5),
                      Text(pObj["rate"], style: TextStyle(color: TColor.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text(pObj["food_type"], style: TextStyle(color: TColor.secondaryText, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text("Menu Items", style: TextStyle(color: TColor.primaryText, fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
            ),

            // Menu List
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              itemCount: menuArr.length,
              itemBuilder: (context, index) {
                var mObj = menuArr[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(mObj["image"], width: 80, height: 80, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mObj["name"], style: TextStyle(color: TColor.primaryText, fontSize: 15, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text("Rs. ${mObj["price"]}", style: TextStyle(color: TColor.primary, fontSize: 14, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showAddToCart(context, mObj),
                        icon: Icon(Icons.add_circle, color: TColor.primary, size: 30),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}