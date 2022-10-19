import 'package:basic_app/api/fetch_weather.dart';
import 'package:basic_app/model/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _lat = 0.0.obs;
  final RxDouble _long = 0.0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLat() => _lat;
  RxDouble getLong() => _long;

  final weatherData = WeatherData().obs;

  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error('Location services are disabled.');
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission != LocationPermission.whileInUse &&
          locationPermission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $locationPermission).');
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      return FetchWeatherApi()
          .processData(value.latitude, value.longitude)
          .then((val) {
        weatherData.value = val;
        _isLoading.value = false;
      });
    });
  }
}
