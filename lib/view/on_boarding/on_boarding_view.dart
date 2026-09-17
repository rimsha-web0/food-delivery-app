import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'package:food_delivery/view/main_tabview/main_tabview.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  List pageArr = [
    {
      "title": "Find Food You Love",
      "subtitle":
      "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep",
      "image": "assets/img/on_boarding_1.png",
    },
    {
      "title": "Fast Delivery",
      "subtitle": "Fast food delivery to your home, office wherever you are",
      "image": "assets/img/on_boarding_2.png",
    },
    {
      "title": "Live Tracking",
      "subtitle":
      "Real time tracking of your food on the app once you placed the order",
      "image": "assets/img/on_boarding_3.png",
    },
  ];

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        selectPage = controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pageArr.length,
            itemBuilder: ((context, index) {
              var pObj = pageArr[index] as Map? ?? {};
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image container fixed size
                    Container(
                      width: 300,
                      height: 300,
                      alignment: Alignment.center,
                      child: Image.asset(
                        pObj["image"].toString(),
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Title
                    Text(
                      pObj["title"].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        pObj["subtitle"].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(), // push dots + button to bottom
              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pageArr.map((e) {
                  var index = pageArr.indexOf(e);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color:
                      index == selectPage ? TColor.primary : TColor.placeholder,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Next button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RoundButton(
                  title: "Next",
                  onPressed: () {
                    if (selectPage >= 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainTabView(),
                        ),
                      );
                    } else {
                      setState(() {
                        selectPage++;
                        controller.animateToPage(
                          selectPage,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceInOut,
                        );
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}