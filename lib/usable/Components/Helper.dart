import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static Future<void> saveUserLoggedInSharedPreference(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  static Future<bool> getUserLoggedInSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Default to false if not set
  }
}