// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:basic_app/screens/auth_screen.dart';
import 'package:basic_app/screens/home_screen.dart';
import 'package:basic_app/services/auth_service.dart';
import 'package:basic_app/controller/global_controller.dart';
import 'package:basic_app/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: BindingsBuilder(() {
        Get.put(
          GlobalController(),
          permanent: true,
        ); // Initialize the controller
      }),
      home: FutureBuilder<bool>(
        future: _authService.isLoggedIn(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.data == true) {
            return const HomeScreen();
          }
          return const AuthScreen();
        },
      ),
      routes: {
        '/auth': (ctx) => const AuthScreen(),
        '/home': (ctx) => const HomeScreen(),
      },
    );
  }
}
