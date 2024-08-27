import 'package:ecommerce/cubit/get_favorites_cubit.dart';
import 'package:ecommerce/cubit/get_products_cubit.dart';
import 'package:ecommerce/screens/MainApp.dart';
import 'package:ecommerce/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAjqgnOIoVQNvCUfSXXoOK0wCNsYqUV44I',
      appId: '1:516046146283:web:6ddc7d8b3fcc3726a38cae',
      messagingSenderId: '516046146283',
      projectId: 'ecommerce-3ee17',
      authDomain: 'ecommerce-3ee17.firebaseapp.com',
      storageBucket: 'ecommerce-3ee17.appspot.com',
    ),
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splashScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProductsCubit()..GetProducts(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce',
        home: MainApp(),
      ),
    );
  }
}
