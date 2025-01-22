// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://weather-server-sandy.vercel.app';
  static const String tokenKey = 'auth_token';

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final token = json.decode(response.body)['token'];
        await _saveToken(token);
        return token;
      }
      throw Exception(json.decode(response.body)['error'] ?? 'Login failed');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final token = json.decode(response.body)['token'];
        await _saveToken(token);
        return token;
      }
      throw Exception(
          json.decode(response.body)['error'] ?? 'Registration failed');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
