import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clustering_google_maps/clustering_google_maps.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluster/fluster.dart';
class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = Set();
  final int _minClusterZoom = 0;
  final int _maxClusterZoom = 19;
  Fluster<MapMarker> _clusterManager;
  double _currentZoom = 15;
  bool _isMapLoading=true;
  bool _areaMarkersLoading=true;
  final String _markerImageUrl = 'https://img.icons8.com/office/80/000000/marker.png';
  final Color _clusterColor = Colors.blue;
  final Color _clusterTextColor = Colors.white;

  final List<LatLng> _markerLocations = [
    LatLng(23.0215, 72.5714),
    LatLng(23.0225, 72.5725),
    LatLng(23.0230, 72.5739),
    LatLng(23.0241, 72.5740),
    LatLng(23.0255, 72.5751),
    LatLng(23.0264, 72.5760),
    LatLng(23.0276, 72.5774),
    LatLng(23.0280, 72.5780),
    LatLng(23.0276, 72.5774)
  ];
  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(47.9221, 106.9155), zoom: 8));
  }
}
