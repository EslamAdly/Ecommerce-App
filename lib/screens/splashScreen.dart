import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/screens/LoginScreen.dart';
import 'package:ecommerce/screens/OnBoardingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        //  backgroundColor: Color(0xff071952),
        //  backgroundColor: Color(0xff153448),
        splashIconSize: 400,
        splash: Image.asset("assets/images/logo.png"),
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: CheckUserLogin(),),
    );
  }
  Widget CheckUserLogin() {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If the user is logged in, navigate to the HomeScreen
      return MyApp();
    } else {
      // If the user is not logged in, navigate to the LoginScreen
      return LoginScreen();
    }
  }
}
