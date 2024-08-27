import 'package:ecommerce/screens/AccountScreen.dart';
import 'package:ecommerce/screens/FavoriteScreen.dart';
import 'package:ecommerce/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;
  List<Widget> widgetPage = [
     Homescreen(),
     FavoriteScreen(),
     MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "E-commerce",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff008bff),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xff008bff),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favourites"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          ]),
      body: widgetPage.elementAt(currentIndex),
    );
  }
}
