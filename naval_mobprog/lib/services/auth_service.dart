import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'https://dummyjson.com';

  // Authenticate user and save session
  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'expiresInMins': 60, // Optional: Sets token expiry time
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Save user data to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token'] ?? '');
        await prefs.setString('username', data['username'] ?? '');
        await prefs.setString('firstName', data['firstName'] ?? '');
        await prefs.setString('lastName', data['lastName'] ?? '');
        await prefs.setString('image', data['image'] ?? '');
        await prefs.setInt('id', data['id'] ?? 0);

        return true; // Login successful
      }
      return false; // Login failed (e.g., wrong credentials)
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Logout method to clear session
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}