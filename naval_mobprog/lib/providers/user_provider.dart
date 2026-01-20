import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _username = 'Christopher Naval'; // Default username
  
  String get username => _username;

  // Method to update username when user logs in
  void setUsername(String newUsername) {
    _username = newUsername;
    notifyListeners(); // Notify all listeners about the change
  }

  // Method to clear username on logout
  void clearUsername() {
    _username = 'Christopher Naval';
    notifyListeners();
  }
}