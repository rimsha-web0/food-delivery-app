import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_icon_button.dart';
import 'package:food_delivery/view/more/add_card_view.dart';
import '../../common_widget/round_button.dart';

class PaymentDetailsView extends StatefulWidget {
  const PaymentDetailsView({super.key});

  @override
  State<PaymentDetailsView> createState() => _PaymentDetailsViewState();
}

class _PaymentDetailsViewState extends State<PaymentDetailsView> {
  // Yeh list ab dynamically update hogi
  List cardArr = [
    {"icon": "assets/img/visa_icon.png", "card": "**** **** **** 2187"}
  ];

  String selectMethod = "COD";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 46),
            // Header (Back button, Title, Cart) - Same as before...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  IconButton(onPressed: () => Navigator.pop(context), icon: Image.asset("assets/img/btn_back.png", width: 20)),
                  const SizedBox(width: 8),
                  Expanded(child: Text("Payment Details", style: TextStyle(color: TColor.primaryText, fontSize: 20, fontWeight: FontWeight.w800))),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(color: TColor.textfield, boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]),
              child: Column(
                children: [
                  // Cash on Delivery
                  _buildMethodTile("Cash/Card On Delivery", "COD"),
                  const Divider(indent: 35, endIndent: 35),

                  // Cards List
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cardArr.length,
                    itemBuilder: (context, index) {
                      var cObj = cardArr[index];
                      return _buildCardTile(cObj, index);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundIconButton(
                title: "Add Another Card",
                icon: "assets/img/add.png",
                color: TColor.primary,
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => AddCardView(
                      onAdd: (newCard) {
                        setState(() {
                          cardArr.add(newCard); // Naya card list mein add ho gaya!
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodTile(String title, String method) {
    return InkWell(
      onTap: () => setState(() => selectMethod = method),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: selectMethod == method ? TColor.primary : TColor.primaryText, fontSize: 14, fontWeight: FontWeight.w700)),
            if (selectMethod == method) Image.asset("assets/img/check.png", width: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTile(Map cObj, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
      child: Row(
        children: [
          Image.asset(cObj["icon"], width: 40),
          const SizedBox(width: 15),
          Expanded(child: Text(cObj["card"], style: const TextStyle(fontWeight: FontWeight.w600))),
          RoundButton(
            title: "Delete",
            fontSize: 11,
            onPressed: () => setState(() => cardArr.removeAt(index)),
            type: RoundButtonType.textPrimary,
          )
        ],
      ),
    );
  }
}