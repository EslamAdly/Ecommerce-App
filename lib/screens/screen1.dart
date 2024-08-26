import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class screen1 extends StatelessWidget {
  screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset("assets/lotties/Animation - 1724260234503.json"),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Shoppin for now",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Shop anytime, anywhere—your next purchase is just a tap away!",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
