import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_pro/usable/Store/Store.dart';

class RESTAPI {
  static Future<int> sendOTP(String phone) async {
    try {
      final Map<String, dynamic> response = {};
      final Map<String, String> content = {'areaCode': '976', 'phone': phone};
      final request = await http.post(
          Uri.parse('http://192.168.1.118:3000/v1/auth/send/phone'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200
          ? json.decode(request.body)['data']['confirmationId']
          : 0;
    } catch (error) {
      return 0;
    }
  }

  static Future<String> verifyOTP(String otp, int id) async {
    try {
      final Map<String, dynamic> content = {'code': otp, 'confirmationId': id};
      final request = await http.post(
          Uri.parse('http://192.168.1.118:3000/v1/auth/validate/phone'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200
          ? json.decode(request.body)['status']
          : '';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<String> createUser(
      int id, String username, String password, String phone) async {
    try {
      final Map<String, dynamic> register = {
        'confirmationId': id,
        'username': username,
        'password': password,
        'areaCode': '976',
        'phone': phone
      };
      final request = await http.post(
          Uri.parse('http://192.168.1.118:3000/v1/auth/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(register));
      return request.statusCode == 200
          ? json.decode(request.body)['status']
          : 'Something has error!';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<String> login(String phone, String password) async {
    try {
      final Map<String, dynamic> content = {
        'areaCode': '976',
        'phone': phone,
        'password': password
      };
      final request = await http.post(
          Uri.parse('http://192.168.1.118:3000/v1/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      if (request.statusCode == 200) {
        Store.accessToken = json.decode(request.body)['data']['accessToken'];
      }
      return request.statusCode == 200
          ? json.decode(request.body)['status']
          : 'Something has wrong';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<List<dynamic>> getPlaces() async {
    try {
      final request = await http.get(
          Uri.parse('https://api.carcare.mn/v1/shop'),
          headers: {'Authorization': 'Bearer ${Store.remote_accessToken}'});
      return request.statusCode == 200 ? json.decode(request.body)['data'] : [];
    } catch (error) {
      return [];
    }
  }

  static Future<List<dynamic>> getServices() async {
    try {
      final request = await http.get(
          Uri.parse('https://api.carcare.mn/v1/utils/service'),
          headers: {'Authorization': 'Bearer ${Store.remote_accessToken}'});
      return request.statusCode == 200 ? json.decode(request.body)['data'] : [];
    } catch (error) {
      return [];
    }
  }

  static Future<int> createExpense(
      String place, int amount, int id, String date) async {
    try {
      final Map<String, dynamic> content = {
        'servicePlace': place,
        'amount': amount,
        'serviceId': id,
        'serviceDate': date
      };
      final request = await http.post(
          Uri.parse('http://192.168.1.118:3000/v1/user/expense'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
            'Content-Type': 'application/json'
          },
          body: json.encode(content));
      return request.statusCode == 200 ? 1 : 0;
    } catch (error) {
      return 0;
    }
  }

  static Future<List<dynamic>> getExpense() async {
    try {
      final request = await http.get(
          Uri.parse('http://192.168.1.118:3000/v1/user/expense'),
          headers: {'Authorization': 'Bearer ${Store.accessToken}'});
      return request.statusCode == 200 ? json.decode(request.body)['data'] : '';
    } catch (error) {
      return [];
    }
  }

  static Future<String> updateUser(int id, String username, String phone, String password) async {
    try {
      final Map<String, dynamic> content = {
        "confirmationId": id,
        "username": username,
        "phone": phone,
        "password": password
      };
      final request = await http.patch(Uri.parse('http://192.168.1.118:3000/v1/auth/update'),
      headers: {
        'Authorization': 'Bearer ${Store.accessToken}',
        'Content-Type': 'application/json'
      },
      body: json.encode(content));
      return request.statusCode == 200 ? json.decode(request.body)['status'] : '';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<String> forgotPassword (int id, String password) async {
    try {
      final Map<String, dynamic> content = {
        "password": password,
        "confirmationId": id
      };
      final request = await http.post(Uri.parse('http://192.168.1.118:3000/v1/auth/forgot'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content)
      );
      return request.statusCode == 200 ? json.decode(request.body)['status'] : '';
    }catch(error){
      return error.toString();
    }
  }

  static Future<String> getUser(String phone, String password) async {
    try {
      final Map<String, String> content = {
        "areaCode": "976",
        "phone": phone,
        "password": password
      };
      final request = await http.get(Uri.parse('http://192.168.1.118:3000/v1/auth/identity'),
        headers: {
          'Authorization': 'Bearer ${Store.accessToken}',
        }
      );
        return request.statusCode == 200 ? json.decode(request.body)['data']['username'] : '';
    } catch(error){
        return error.toString();
    }
  }
}
