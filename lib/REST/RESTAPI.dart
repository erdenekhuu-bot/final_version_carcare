import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_pro/usable/Store/Store.dart';

class RESTAPI {
  static Future<int> sendOTP(String phone) async {
    try {
      final Map<String, dynamic> response={};
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

  static Future<String> createUser(int id, String username, String password, String phone) async {
        try {
          final Map<String, dynamic> register={
            'confirmationId': id,
        'username': username,
        'password': password,
        'areaCode': '976',
        'phone': phone
      };
      final request = await http.post(Uri.parse('http://192.168.1.118:3000/v1/auth/register'),
          headers: {'Content-Type': 'application/json'}, 
          body: json.encode(register)
      );
      return request.statusCode == 200 ? json.decode(request.body)['status'] : 'Something has error!';
    } catch(error){
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
       final request = await http.post(Uri.parse('http://192.168.1.118:3000/v1/auth/login'), 
            headers: {'Content-Type': 'application/json'},
            body: json.encode(content)
       );
       if(request.statusCode == 200){
          Store.accessToken=json.decode(request.body)['data']['accessToken'];
       }
      return request.statusCode == 200 ? json.decode(request.body)['status'] : 'Something has wrong';
    }catch(error){
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
