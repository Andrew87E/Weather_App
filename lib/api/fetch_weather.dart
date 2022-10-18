import 'dart:convert';

import 'package:basic_app/api/api_key.dart';
import 'package:basic_app/model/weather_data_current.dart';
import 'package:http/http.dart' as http;

import '../model/weather_data.dart';

class FetchWeatherApi {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, long) async {
    var res = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=-$long&units=imperial&appid=$apiKey&exclude=minutely'));
    var jsonString = jsonDecode(res.body);
    weatherData = WeatherData(current: WeatherDataCurrent.fromJson(jsonString));

    return weatherData!;
  }
}
