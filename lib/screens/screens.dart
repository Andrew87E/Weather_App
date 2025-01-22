// lib/screens/screens.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:basic_app/screens/home_screen.dart';
import 'package:basic_app/screens/settings_screen.dart';
import 'package:basic_app/screens/auth_screen.dart';
import 'package:basic_app/controller/global_controller.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int _selectedIndex = 0;
  final GlobalController globalController = Get.find<GlobalController>();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Text(
      'Index 1: Saved',
      style: optionStyle,
    ),
    const Text(
      'Index 2: Search',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!globalController.isAuthenticated().value) {
        return const AuthScreen();
      }

      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => globalController.logout(),
            ),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.cyan[400],
          onTap: _onItemTapped,
        ),
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
