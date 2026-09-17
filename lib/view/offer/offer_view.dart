import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import '../../common_widget/popular_resutaurant_row.dart';
import '../menu/item_details_view.dart';
import '../more/my_order_view.dart';
import 'OffersDetailView.dart'; // ✅ Is file ko import lazmi karein

class OfferView extends StatefulWidget {
  const OfferView({super.key});

  @override
  State<OfferView> createState() => _OfferViewState();
}

class _OfferViewState extends State<OfferView> {
  TextEditingController txtSearch = TextEditingController();

  List<Map<String, dynamic>> offerArr = [
    {
      "image": "assets/img/offer_1.png",
      "name": "Café de Noires",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food",
      "off": "20% OFF",
      "date": "Valid till 10th May"
    },
    {
      "image": "assets/img/offer_2.png",
      "name": "Isso",
      "rate": "4.8",
      "rating": "150",
      "type": "Cafa",
      "food_type": "Western Food",
      "off": "30% OFF",
      "date": "Valid till 15th May"
    },
    {
      "image": "assets/img/offer_3.png",
      "name": "Cafe Beans",
      "rate": "4.7",
      "rating": "90",
      "type": "Cafa",
      "food_type": "Western Food",
      "off": "15% OFF",
      "date": "Valid till 12th May"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 46),

              // ✅ Header with Fixed Cart Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Latest Offers",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
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
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  "Find discounts, Offers special\nmeals and more!",
                  style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 15),

              // ✅ Check Offers Button with Navigation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 140,
                  height: 30,
                  child: RoundButton(
                    title: "Check Offers",
                    fontSize: 12,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OffersDetailView(),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ 3 Horizontal Categories (Modern UI)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryItem("Fast Food", "assets/img/cat_3.png"),
                    _buildCategoryItem("Healthy Food", "assets/img/cat_4.png"),
                    _buildCategoryItem("Desserts", "assets/img/dess_1.png"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Offers List
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: offerArr.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> pObj = offerArr[index];
                  return PopularRestaurantRow(
                    pObj: pObj,
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ItemDetailsView()),
                    );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Category Item Helper
  Widget _buildCategoryItem(String title, String image) {
    return Column(
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            color: TColor.textfield,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Image.asset(image, fit: BoxFit.contain),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              color: TColor.primaryText,
              fontSize: 12,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}