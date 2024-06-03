import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RESTAPI {
  static Future<Map<String, dynamic>> sendOTP(String phone) async {
    try {
      final Map<String, dynamic> response={};
      final Map<String, String> content = {'areaCode': '976', 'phone': phone};
      final request = await http.post(
          Uri.parse('http://192.168.1.118:3000/v1/auth/send/phone'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      // return request.statusCode == 200
      //     ? json.decode(request.body)['data']['confirmationId']
      //     : 0;
      if(request.statusCode == 200){
          response.addAll({
            'confirmationId': json.decode(request.body)['data']['confirmationId'],
            'status': json.decode(request.body)['data']['status']
          });
      }
      return response;
    } catch (error) {
      return {};
    }
  }

  static Future<String> verifyOTP(String otp, int id) async {
    try {
      final Map<String, dynamic> content = {'code': otp, 'confirmationId': id};
      final request = await http.post(
          Uri.parse('https://api.carcare.mn/v1/auth/send/phone'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200
          ? json.decode(request.body)['data']['confirmationId']
          : '';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<String> updateUser() async {
    try {
      return '';
    } catch (error) {
      return '';
    }
  }

  static Future<String> createExpense() async {
    try {
      return '';
    } catch (error) {
      return error.toString();
    }
  }
}
