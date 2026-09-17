import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery/common_widget/round_icon_button.dart';
import '../../common/color_extension.dart';
import '../more/my_order_view.dart';

class ItemDetailsView extends StatefulWidget {
  const ItemDetailsView({super.key});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  // ✅ Price changed to PKR (3000)
  double basePrice = 3000.0;
  double price = 3000.0;
  int qty = 1;
  bool isFav = false;

  String? selectedSize;
  String? selectedIngredient;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            "assets/img/detail_top.png",
            width: media.width,
            height: media.width,
            fit: BoxFit.cover,
          ),
          Container(
            width: media.width,
            height: media.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: media.width - 60),
                Container(
                  decoration: BoxDecoration(
                      color: TColor.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "Tandoori Chicken Pizza",
                            style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 18,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: TColor.primary,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      " 4 Star Ratings",
                                      style: TextStyle(
                                          color: TColor.primary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Rs. ${price.toStringAsFixed(0)}", // ✅ Changed to Rs.
                                    style: TextStyle(
                                        color: TColor.primaryText,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "/per Portion",
                                    style: TextStyle(
                                        color: TColor.primaryText,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text("Description",
                              style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "Savor the taste of our authentic Tandoori Chicken Pizza, topped with marinated chicken, fresh onions, and premium mozzarella.",
                            style: TextStyle(
                                color: TColor.secondaryText, fontSize: 12),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Divider(
                                color: TColor.secondaryText.withOpacity(0.4),
                                height: 1)),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text("Customize your Order",
                              style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(height: 20),

                        _buildDropdown(
                            "Select the size of portion",
                            ["Small", "Medium", "Big"],
                            selectedSize, (val) {
                          setState(() {
                            selectedSize = val;
                            if (val == "Big") {
                              price = basePrice + 500; // PKR increments
                            } else if (val == "Small") {
                              price = basePrice - 300;
                            } else {
                              price = basePrice;
                            }
                          });
                        }),
                        const SizedBox(height: 15),
                        _buildDropdown(
                            "Select the ingredients",
                            ["Extra Cheese", "Mushrooms", "Olives"],
                            selectedIngredient, (val) {
                          setState(() => selectedIngredient = val);
                        }),

                        const SizedBox(height: 25),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Text("Number of Portions",
                                  style: TextStyle(
                                      color: TColor.primaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                              const Spacer(),
                              _qtyBtn("-", () {
                                if (qty > 1) {
                                  setState(() => qty--);
                                }
                              }),
                              Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(color: TColor.primary),
                                    borderRadius: BorderRadius.circular(12.5)),
                                child: Text(qty.toString(),
                                    style: TextStyle(
                                        color: TColor.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              _qtyBtn("+", () => setState(() => qty++)),
                            ],
                          ),
                        ),

                        _buildBottomCart(media),
                      ]),
                ),
              ],
            ),
          ),
          _buildFavBtn(media),
          _buildHeader(context),
        ],
      ),
    );
  }

  // --- Helpers ---

  Widget _buildDropdown(String hint, List<String> items, String? value,
      Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: TColor.textfield, borderRadius: BorderRadius.circular(5)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            value: value,
            items: items
                .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e,
                    style: TextStyle(
                        color: TColor.primaryText, fontSize: 14))))
                .toList(),
            onChanged: (val) => onChanged(val.toString()),
            hint: Text(hint,
                style: TextStyle(color: TColor.secondaryText, fontSize: 14)),
          ),
        ),
      ),
    );
  }

  Widget _qtyBtn(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: TColor.primary, borderRadius: BorderRadius.circular(12.5)),
        child: Text(title,
            style: TextStyle(
                color: TColor.white,
                fontSize: 14,
                fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildBottomCart(Size media) {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: media.width * 0.25,
            height: 160,
            decoration: BoxDecoration(
                color: TColor.primary,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
          ),
          Center(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 20),
                  width: media.width - 80,
                  height: 140, // ✅ Height increased to fix pixel issue
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 4))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total Price",
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5),
                      Text("Rs. ${(price * qty).toStringAsFixed(0)}", // ✅ Changed to Rs.
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 21,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 140,
                        height: 35, // ✅ Height 35 to fix Add to Cart text overflow
                        child: RoundIconButton(
                            title: "Add to Cart",
                            icon: "assets/img/shopping_add.png",
                            color: TColor.primary,
                            onPressed: btnAddToCart),
                      )
                    ],
                  ),
                ),
                _cartFloatingBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cartFloatingBtn() {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyOrderView())),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.5),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
            ]),
        alignment: Alignment.center,
        child: Image.asset("assets/img/shopping_cart.png",
            width: 20, height: 20, color: TColor.primary),
      ),
    );
  }

  Widget _buildFavBtn(Size media) {
    return Container(
      height: media.width - 20,
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.only(right: 4),
      child: InkWell(
          onTap: () => setState(() => isFav = !isFav),
          child: Image.asset(
              isFav ? "assets/img/favorites_btn.png" : "assets/img/favorites_btn_2.png",
              width: 70,
              height: 70)),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(children: [
        const SizedBox(height: 35),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Image.asset("assets/img/btn_back.png",
                  width: 20, height: 20, color: TColor.white)),
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const MyOrderView())),
              icon: Image.asset("assets/img/shopping_cart.png",
                  width: 25, height: 25, color: TColor.white)),
        ]),
      ]),
    );
  }

  void btnAddToCart() async {
    if (selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a size first!")));
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    showDialog(
        context: context,
        builder: (context) =>
        const Center(child: CircularProgressIndicator()));
    try {
      String cartId = "Pizza_${selectedSize}";
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("cart")
          .doc(cartId)
          .set({
        "name": "Tandoori Chicken Pizza",
        "price": price,
        "qty": qty,
        "size": selectedSize,
        "ingredient": selectedIngredient ?? "Standard",
        "total": price * qty,
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Added to Cart!")));
    } catch (e) {
      Navigator.pop(context);
    }
  }
}