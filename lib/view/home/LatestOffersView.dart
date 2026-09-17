import 'package:flutter/material.dart';
import '../../common/color_extension.dart';
import '../../common_widget/popular_resutaurant_row.dart';

class LatestOffersView extends StatelessWidget {
  const LatestOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    List offersArr = [
      {
        "image": "assets/img/res_1.png",
        "name": "Burger King - 50% OFF",
        "rate": "4.9",
        "rating": "124",
        "type": "Fast Food",
        "food_type": "Burgers"
      },
      {
        "image": "assets/img/res_2.png",
        "name": "Pizza Hut - Flat 50%",
        "rate": "4.8",
        "rating": "200",
        "type": "Cafe",
        "food_type": "Italian"
      },
    ];

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
        title: Text("Latest Offers", style: TextStyle(color: TColor.primaryText, fontSize: 20, fontWeight: FontWeight.w800)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 50% OFF Banner ---
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: TColor.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text("FLAT 50% OFF\nOn All Deals", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: offersArr.length,
              itemBuilder: (context, index) {
                var pObj = offersArr[index];
                return PopularRestaurantRow(pObj: pObj, onTap: () {});
              },
            ),
          ],
        ),
      ),
    );
  }
}