import 'package:basic_app/tabs/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: null);
  }
}
