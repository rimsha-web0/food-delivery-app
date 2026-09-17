import 'package:flutter/material.dart';
import '../../common/color_extension.dart';

class ItemDetailsView extends StatelessWidget {
  // ✅ HomeView aur MenuItemsView se aane wala data yahan receive hoga
  final Map<String, dynamic> mObj;

  const ItemDetailsView({super.key, required this.mObj});

  // --- 🛒 ADD TO CART BOTTOM SHEET ---
  void _showAddToCart(BuildContext context, Map item) {
    int qty = 1;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Behtar layout ke liye
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
                Text(item["name"] ?? "Item",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Text("Rs. ${item["price"] ?? "0"}",
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
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item["name"]} added to cart!")),
                    );
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
    // Category name nikalne ke liye
    String categoryName = mObj["name"].toString();

    List getItems() {
      if (categoryName == "Indian") {
        return [
          {"name": "Chicken Biryani", "image": "asstes/cat_4.png", "price": "850"},
          {"name": "Paneer Tikka", "image": "https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?q=80&w=500", "price": "450"},
          {"name": "Butter Chicken", "image": "cat_sri.png", "price": "950"},
        ];
      } else if (categoryName == "Italian") {
        return [
          {"name": "Cheese Pizza", "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=500", "price": "1500"},
          {"name": "White Pasta", "image": "assets/m_res1.png", "price": "1200"},
        ];
      } else if (categoryName == "Sri Lankan") {
        return [
          {"name": "Kottu Roti", "image": "https://images.unsplash.com/photo-1627308595229-7830a5c91f9f?q=80&w=500", "price": "600"},
          {"name": "Fish Curry", "image": "https://images.unsplash.com/photo-1505253716362-afaea1d3d1af?q=80&w=500", "price": "900"},
        ];
      } else {
        // Agar koi specific category match na ho (Offers etc.)
        return [
          {"name": "Special Deal", "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=500", "price": "700"},
        ];
      }
    }

    var items = getItems();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: TColor.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(categoryName,
            style: TextStyle(
                color: TColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w800)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        itemCount: items.length,
        itemBuilder: (context, index) {
          var pObj = items[index];
          String imgPath = pObj["image"]!;

          return Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: imgPath.startsWith("http")
                      ? Image.network(imgPath,
                      width: double.infinity, height: 200, fit: BoxFit.cover)
                      : Image.asset(imgPath,
                      width: double.infinity, height: 200, fit: BoxFit.cover),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pObj["name"]!,
                            style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                        Text("Rs. ${pObj["price"]}",
                            style: TextStyle(
                                color: TColor.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    IconButton(
                      onPressed: () => _showAddToCart(context, pObj),
                      icon: Icon(Icons.add_circle, color: TColor.primary, size: 35),
                    ),
                  ],
                ),
                const Text("Order now for fresh delivery",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}