import 'package:basic_app/controller/global_controller.dart';
import 'package:basic_app/widgets/header.dart';
import 'package:basic_app/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/current_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AeNav(),
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              // ignore: avoid_unnecessary_containers
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(height: 20),
                    const Header(),
                    CurrentWeather(
                      weatherDataCurrent:
                          globalController.getWeatherData().getCurrentWeather(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
