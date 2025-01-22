// lib/controller/global_controller.dart
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:basic_app/api/fetch_weather.dart';
import 'package:basic_app/model/weather_data.dart';
import 'package:basic_app/services/auth_service.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final RxBool _isAuthenticated = false.obs;

  final AuthService _authService = AuthService();
  final FetchWeatherAPI _weatherAPI = FetchWeatherAPI();

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;
  RxBool isAuthenticated() => _isAuthenticated;

  final weatherData = WeatherData().obs;

  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  Future<void> checkAuth() async {
    final isLoggedIn = await _authService.isLoggedIn();
    _isAuthenticated.value = isLoggedIn;
    if (isLoggedIn) {
      getLocation();
    }
  }

  Future<void> getLocation() async {
    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        throw Exception("Location not enabled");
      }

      LocationPermission locationPermission =
          await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        throw Exception("Location permission are denied forever");
      } else if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          throw Exception("Location permission is denied");
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _latitude.value = position.latitude;
      _longitude.value = position.longitude;

      weatherData.value =
          await _weatherAPI.processData(position.latitude, position.longitude);

      _isLoading.value = false;
    } catch (e) {
      print("Error getting location or weather: $e");
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated.value = false;
    Get.offAllNamed('/auth');
  }

  RxInt getIndex() {
    return _currentIndex;
  }

  Future<Map<String, dynamic>> getApiUsage() {
    return _weatherAPI.getApiUsage();
  }
}
