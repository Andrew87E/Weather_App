import 'package:basic_app/services/auth_service.dart';

Future<String> apiURL(var lat, var lon) async {
  const baseUrl = 'https://weather-server-sandy.vercel.app';

  final authService = AuthService();
  final token = await authService.getToken();

  if (token == null) {
    throw Exception('Not authenticated');
  }

  return '$baseUrl/api/weather/$lat/$lon';
}

Future<Map<String, String>> getApiHeaders() async {
  final authService = AuthService();
  final token = await authService.getToken();

  if (token == null) {
    throw Exception('Not authenticated');
  }

  return {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };
}
