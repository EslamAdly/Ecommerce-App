import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens/screen1.dart';
import '../screens/screen2.dart';
import '../screens/screen3.dart';
import '../screens/screen4.dart';

class Onboarding_screen extends StatefulWidget {
  Onboarding_screen({super.key});

  @override
  State<Onboarding_screen> createState() => _Onboarding_screenState();
}

class _Onboarding_screenState extends State<Onboarding_screen> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              screen1(),
              screen2(),
              screen3(),
              screen4(),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ));
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 17, color: Colors.redAccent),
                  ),
                ),
                SmoothPageIndicator(controller: pageController, count: 4),
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
