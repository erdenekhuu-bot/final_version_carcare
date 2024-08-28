import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapModel extends ChangeNotifier {
  List<dynamic> _shops = [];
  List<LatLng> _places = [];

  // Getters
  List<dynamic> get shops => _shops;
  List<LatLng> get places => _places;

  // Setters
  void setShops(List<dynamic> newShops) {
    _shops = newShops ?? [];
    notifyListeners();
  }

  void setPlaces(List<LatLng> newPlaces) {
    _places = newPlaces ?? [];
    notifyListeners();
  }
}