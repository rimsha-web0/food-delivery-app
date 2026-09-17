import 'package:flutter/material.dart';
import '../../common/color_extension.dart';

class OffersDetailView extends StatefulWidget {
  const OffersDetailView({super.key});

  @override
  State<OffersDetailView> createState() => _OffersDetailViewState();
}

class _OffersDetailViewState extends State<OffersDetailView> {

  String selectFilter = "All";
  List<String> filterArr = ["All", "Restaurants", "Fast Food", "Drinks"];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.white,
      appBar: AppBar(
        backgroundColor: TColor.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: TColor.primaryText),
        ),
        title: Text(
          "Exclusive Offers",
          style: TextStyle(
              color: TColor.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 1. Top Banner
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/img/offer_1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("50% OFF",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                      const Text("On your first 3 orders",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                            color: TColor.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text("Use Code: SAVE50",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // 🎯 3. Filter Chips (Now Pressable)
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: filterArr.length,
                itemBuilder: (context, index) {
                  var title = filterArr[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectFilter = title;
                      });
                    },
                    child: _filterChip(title, selectFilter == title),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // 🍕 2. Offer Cards List
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildOfferCard(media, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String title, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isActive ? TColor.primary : TColor.textfield,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(title,
          style: TextStyle(
              color: isActive ? Colors.white : TColor.secondaryText,
              fontSize: 12,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildOfferCard(Size media, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/img/offer_${index + 1}.png",
                width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Restaurant Name",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("30% OFF - Valid Today",
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Text("CODE: SAVE50",
                    style: TextStyle(color: TColor.secondaryText, fontSize: 11)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _btnApplyCode(),
            style: ElevatedButton.styleFrom(
              backgroundColor: TColor.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: const Text("Apply",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          )
        ],
      ),
    );
  }

  // ✅ Apply Code Dialog Logic
  void _btnApplyCode() {
    TextEditingController txtCode = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Apply Promo Code",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Enter your code to get a special discount!"),
            const SizedBox(height: 15),
            TextField(
              controller: txtCode,
              decoration: InputDecoration(
                hintText: "Promo Code",
                filled: true,
                fillColor: TColor.textfield,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: TColor.secondaryText)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: TColor.primary),
            onPressed: () {
              if (txtCode.text.toUpperCase() == "SAVE50") {
                Navigator.pop(context); // Dialog band
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Congratulations! Your discount has been applied.!🎉"),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid code. Please try again."),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text("Apply", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}