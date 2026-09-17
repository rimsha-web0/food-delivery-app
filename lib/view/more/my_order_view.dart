import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'checkout_view.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: TColor.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .collection("cart")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return _buildEmptyCart();
            }

            var cartDocs = snapshot.data!.docs;

            // ✅ UPDATED CALCULATION LOGIC
            double subTotal = 0;
            for (var doc in cartDocs) {
              var data = doc.data() as Map<String, dynamic>;

              // String ko double mein parse karna zaroori hai kyunki Firebase mein ye string save ho raha hai
              double price = double.tryParse(data["price"].toString()) ?? 0.0;
              int qty = int.tryParse(data["qty"].toString()) ?? 1;

              subTotal += (price * qty);
            }

            double deliveryCost = 150.0;
            double total = subTotal + deliveryCost;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 46),
                    _buildHeader(context),
                    _buildShopInfo(),
                    const SizedBox(height: 20),

                    // DATA LIST SECTION
                    Container(
                      decoration: BoxDecoration(color: TColor.textfield),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: cartDocs.length,
                        separatorBuilder: (context, index) => Divider(
                            indent: 25,
                            endIndent: 25,
                            color: TColor.secondaryText.withOpacity(0.5),
                            height: 1),
                        itemBuilder: (context, index) {
                          var doc = cartDocs[index];
                          var cObj = doc.data() as Map<String, dynamic>;
                          String displayName = cObj["name"] ?? "Item";

                          return Dismissible(
                            key: Key(doc.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              color: Colors.red,
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              _deleteItem(doc.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          displayName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: TColor.primaryText,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "Qty: ${cObj["qty"]}",
                                          style: TextStyle(
                                              color: TColor.secondaryText,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Rs. ${cObj["price"]}",
                                    style: TextStyle(
                                        color: TColor.primaryText,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 5),
                                  IconButton(
                                    onPressed: () => _deleteItem(doc.id),
                                    icon: const Icon(Icons.close, color: Colors.red, size: 18),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    _buildPriceSection(subTotal, deliveryCost, total, cartDocs),
                  ],
                ),
              ),
            );
          }),
    );
  }

  // --- Functions ---

  void _deleteItem(String docId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("cart")
          .doc(docId)
          .delete();
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Item removed from cart"), duration: Duration(seconds: 1)));
      }
    } catch (e) {
      debugPrint("Delete error: $e");
    }
  }

  // --- UI Helpers ---

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text("Your cart is empty", style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Go Back", style: TextStyle(fontWeight: FontWeight.bold))
          )
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset("assets/img/btn_back.png", width: 20, height: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text("My Order", style: TextStyle(color: TColor.primaryText, fontSize: 20, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _buildShopInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/img/shop_logo.png", width: 60, height: 60, fit: BoxFit.cover)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Delicious Food Hub", style: TextStyle(color: TColor.primaryText, fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text("Premium Quality Items", style: TextStyle(color: TColor.secondaryText, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(double subTotal, double deliveryCost, double total, List cartDocs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          const SizedBox(height: 25),
          _priceRow("Sub Total", subTotal),
          const SizedBox(height: 8),
          _priceRow("Delivery Cost", deliveryCost),
          const SizedBox(height: 15),
          Divider(color: TColor.secondaryText.withOpacity(0.5), height: 1),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: TextStyle(color: TColor.primaryText, fontSize: 14, fontWeight: FontWeight.w700)),
              Text("Rs. ${total.toStringAsFixed(0)}", style: TextStyle(color: TColor.primary, fontSize: 22, fontWeight: FontWeight.w800))
            ],
          ),
          const SizedBox(height: 25),
          RoundButton(
              title: "Checkout",
              onPressed: () {
                if (cartDocs.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutView()));
                }
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _priceRow(String title, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: TColor.primaryText, fontSize: 14, fontWeight: FontWeight.w600)),
        Text("Rs. ${value.toStringAsFixed(0)}", style: TextStyle(color: TColor.primaryText, fontSize: 14, fontWeight: FontWeight.w700))
      ],
    );
  }
}