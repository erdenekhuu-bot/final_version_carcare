import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/usable/Components/Helper.dart';

class RESTAPI {
  static http.Client client = http.Client();

  static Future<int> sendOTP(String phone) async {
    try {
      final Map<String, String> content = {'phonenumber': phone};
      final request = await client.post(Uri.parse('https://admin-dev.carcare.mn/api/auth/otp/send/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200 && json.decode(utf8.decode(request.bodyBytes))['success'] == true ? 1 : 0;
    } catch (error) {
      return 404;
    }
  }

  static Future<int> verifyOTP(String otp, String phone) async {
    try {
      final Map<String, dynamic> content = {'otp': otp, 'phone_number': phone};
      final request = await client.post(Uri.parse('https://admin-dev.carcare.mn/api/auth/otp/validate/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200 && json.decode(utf8.decode(request.bodyBytes))['success'] == true ? 1 : 0;
    } catch (error) {
      return 404;
    }
  }

  static Future<String> createUser(
      String username, String password, String phone) async {
    try {
      final Map<String, dynamic> register = {
        'username': username,
        'password': password,
        'phonenumber': phone
      };
      final request = await client.post(
          Uri.parse('https://admin-dev.carcare.mn/api/auth/register/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(register));
      return request.statusCode == 201 ? json.decode(request.body)['token'] : '';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<bool> login(String phone, String password) async {
    try {
      final Map<String, dynamic> content = {'phonenumber': phone, 'password': password};
      final request = await client.post(
        Uri.parse('https://admin-dev.carcare.mn/api/auth/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(content),
      );
      if (request.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(request.body);
        final String accessToken = responseBody['access'];
        final String refreshToken = responseBody['refresh'];
        Store.accessToken = accessToken;
        await Helper.saveToken(refreshToken);
        await Helper.defaultToken(accessToken);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  static Future<String> forgotPassword(String phone, String password) async {
    try {
      final Map<String, dynamic> content = {"phonenumber": phone, "password": password};
      final request = await client.put(
          Uri.parse('https://admin-dev.carcare.mn/api/forgotpassword/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200
          ? json.decode(utf8.decode(request.bodyBytes))['token']
          : '';
    } catch (error) {
      return error.toString();
    }
  }
}


