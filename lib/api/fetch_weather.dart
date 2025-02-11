import 'dart:convert';
import 'package:basic_app/model/weather_data_current.dart';
import 'package:basic_app/model/weather_data_daily.dart';
import 'package:basic_app/model/weather_data_hourly.dart';
import 'package:http/http.dart' as http;
import 'package:basic_app/model/weather_data.dart';
import 'package:basic_app/services/auth_service.dart';

class FetchWeatherAPI {
  static const String baseUrl = 'https://weather-server-sandy.vercel.app';
  final AuthService _authService = AuthService();
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    try {
      final token = await _authService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.get(
        Uri.parse('$baseUrl/api/weather/$lat/$lon'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        weatherData = WeatherData(
          WeatherDataCurrent.fromJson(jsonString),
          WeatherDataHourly.fromJson(jsonString),
          WeatherDataDaily.fromJson(jsonString),
        );
        return weatherData!;
      } else if (response.statusCode == 401) {
        throw Exception('Authentication expired');
      }
      throw Exception('Failed to load weather data');
    } catch (e) {
      throw Exception('Error getting weather data: $e');
    }
  }

  Future<Map<String, dynamic>> getApiUsage() async {
    try {
      final token = await _authService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.get(
        Uri.parse('$baseUrl/api/weather/api-usage'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load API usage');
    } catch (e) {
      throw Exception('Error getting API usage: $e');
    }
  }
}
