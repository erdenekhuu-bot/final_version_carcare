
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Helper {

  static Future<void> saveUserLoggedInSharedPreference(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  static Future<bool> getUserLoggedInSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', token);
  }

  static Future<String?> readToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access');
  }

  static Future<void> defaultToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('defaultToken', token);
  }

  static Future<String?> readDefaultToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('defaultToken');
  }

  static Future<void> username(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  static Future<void> password(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  static Future<void> phone(String phone) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
  }

  static Future<String?> readUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<String?> readPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  static Future<String?> readPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('defaultToken');
    await prefs.remove('access');
  }

  static Future<void> clearName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  static Future<void> clearPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('phone');
  }

  static Future<void> clearPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('password');
  }

  static Future<void> saveValue(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value == null) {
      await prefs.remove(key);
    } else {
      throw ArgumentError('Unsupported value type');
    }
  }

}
