import 'package:google_maps_flutter/google_maps_flutter.dart';

class Store {
  static int confirmationId=0;
  static String remote_accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjksImlhdCI6MTcxNzk3NTYzNSwiZXhwIjoxNzMwOTM1NjM1fQ.k_9fmWodk7dzwWDlmQJHBtMYRmD0frhUbJ7O-wTRWuQ';
  static String accessToken='';
  static List<LatLng> location=[];
  static String storePhone='';
  static String storePassword='';
  static double amount=0;
  static bool month=true;
  static List<LatLng> Addressing = [];
}