import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_icon_button.dart';
import 'package:food_delivery/common_widget/round_textfield.dart';

class AddCardView extends StatefulWidget {
  final Function(Map<String, String>) onAdd; // Naya card wapas bhejne ke liye
  const AddCardView({super.key, required this.onAdd});

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  TextEditingController txtCardNumber = TextEditingController();
  TextEditingController txtCardMonth = TextEditingController();
  TextEditingController txtCardYear = TextEditingController();
  TextEditingController txtCardCode = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();

  void _validateAndSave() {
    String cardNumber = txtCardNumber.text.trim();
    int? month = int.tryParse(txtCardMonth.text.trim());
    int? year = int.tryParse(txtCardYear.text.trim());

    // 1. Card Number Check (Min 14)
    if (cardNumber.length < 14) {
      _showError("Card number must be at least 14 digits");
      return;
    }

    // 2. Month Check (1-12)
    if (month == null || month < 1 || month > 12) {
      _showError("Invalid Month! Please enter 1 to 12");
      return;
    }

    // 3. Year Check (>= 2026)
    if (year == null || year < 2026) {
      _showError("Expiry year must be 2026 or later");
      return;
    }

    // 4. Empty Fields Check
    if (txtFirstName.text.isEmpty || txtCardCode.text.isEmpty) {
      _showError("Please fill all security details");
      return;
    }

    // Agar sab theek hai toh card add karo
    widget.onAdd({
      "icon": "assets/img/visa_icon.png",
      "card": "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}",
    });

    Navigator.pop(context);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: 25, right: 25, top: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Credit/Debit Card", style: TextStyle(color: TColor.primaryText, fontSize: 16, fontWeight: FontWeight.w700)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 15),
            RoundTextfield(hintText: "Card Number", controller: txtCardNumber, keyboardType: TextInputType.number),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text("Expiry", style: TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                SizedBox(width: 80, child: RoundTextfield(hintText: "MM", controller: txtCardMonth, keyboardType: TextInputType.number)),
                const SizedBox(width: 10),
                SizedBox(width: 120, child: RoundTextfield(hintText: "YYYY", controller: txtCardYear, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 15),
            RoundTextfield(hintText: "CVV", controller: txtCardCode, keyboardType: TextInputType.number),
            const SizedBox(height: 15),
            RoundTextfield(hintText: "First Name", controller: txtFirstName),
            const SizedBox(height: 15),
            RoundTextfield(hintText: "Last Name", controller: txtLastName),
            const SizedBox(height: 25),
            RoundIconButton(
              title: "Add Card",
              icon: "assets/img/add.png",
              color: TColor.primary,
              onPressed: _validateAndSave,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}