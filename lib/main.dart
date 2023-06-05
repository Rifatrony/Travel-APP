import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel APP',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

