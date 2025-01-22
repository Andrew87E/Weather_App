import 'package:basic_app/widgets/current_weather_widget.dart';
import 'package:basic_app/widgets/daily_forecast_section.dart';
import 'package:basic_app/widgets/hourly_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:basic_app/controller/global_controller.dart';
import 'package:basic_app/model/weather_data_current.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController = Get.find<GlobalController>();
  RxString cityName = "Loading...".obs;

  @override
  void initState() {
    super.initState();
    // Watch for location changes
    ever(globalController.getLatitude(), (_) => getAddress());
    ever(globalController.getLongitude(), (_) => getAddress());
  }

  getAddress() async {
    if (globalController.getLatitude().value != 0 &&
        globalController.getLongitude().value != 0) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          globalController.getLatitude().value,
          globalController.getLongitude().value,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          cityName.value = place.locality ??
              place.subLocality ??
              place.administrativeArea ??
              "Unknown Location";
          print("City name updated to: ${cityName.value}"); // Debug print
        }
      } catch (e) {
        debugPrint("Error getting location: $e");
        cityName.value = "Location Unavailable";
      }
    }
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => globalController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF82fa5f),
                ),
              )
            : Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.grey[900]!,
                        ],
                      ),
                    ),
                  ),
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        expandedHeight: 120,
                        floating: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getGreeting(),
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                              ),
                              Obx(() => Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Color(0xFF82fa5f),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        cityName.value,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          titlePadding:
                              const EdgeInsets.only(left: 20, bottom: 16),
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.more_vert,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _buildCurrentWeather(
                                globalController.getData().getCurrentWeather(),
                              ),
                              const SizedBox(height: 20),
                              _buildHourlyForecast(
                                globalController.getData().getHourlyWeather(),
                              ),
                              const SizedBox(height: 20),
                              _buildDailyForecast(
                                globalController.getData().getDailyWeather(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildCurrentWeather(WeatherDataCurrent weather) {
    return CurrentWeatherSection(weather: weather);
  }

  _buildHourlyForecast(weatherDataHourly) {
    return HourlyForecastSection(weatherDataHourly: weatherDataHourly);
  }

  _buildDailyForecast(weatherDataDaily) {
    return DailyForecastSection(weatherDataDaily: weatherDataDaily);
  }
}
