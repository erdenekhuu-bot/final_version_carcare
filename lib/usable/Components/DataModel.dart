import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataModel with ChangeNotifier {
  List<dynamic> _dynamicList = [];
  List<LatLng> _latLngList = [];

  List<dynamic> get dynamicList => _dynamicList;
  List<LatLng> get latLngList => _latLngList;

  void addToDynamicList(dynamic item) {
    _dynamicList.add(item);
    notifyListeners();
  }

  void addToLatLngList(LatLng item) {
    _latLngList.add(item);
    notifyListeners();
  }

  void setDynamicList(List<dynamic> list) {
    _dynamicList = list;
    notifyListeners();
  }

  void setLatLngList(List<LatLng> list) {
    _latLngList = list;
    notifyListeners();
  }
}
