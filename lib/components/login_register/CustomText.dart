import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String textTitle;
  final String textBody;

  const CustomText({super.key, required this.textTitle, required this.textBody});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textTitle, // Updated variable name
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            textBody, // Updated variable name
            textAlign: TextAlign.center, // Changed to start alignment
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
