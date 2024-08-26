import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class screen3 extends StatelessWidget {
  screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset("assets/lotties/Animation - 1724260298485.json"),
          SizedBox(
            height: 40,
          ),
          Text(
            "Instant shopping",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Browse, buy, and smile—your shopping experience reimagined",
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
