import 'package:basic_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Screens(),
      title: "Weather",
      debugShowCheckedModeBanner: false,
    );
  }
}
