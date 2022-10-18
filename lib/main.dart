import 'package:basic_app/screens/favorites_screen.dart';
import 'package:basic_app/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(title: 'Home'),
        '/Favorites': (context) => const FavoritesScreen(title: 'Favorites'),
        '/search': (context) => const SearchScreen(title: 'Search'),
      },
    );
  }
}
