import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsssState();
}

class _MapsssState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(47.9221, 106.9155), zoom: 8));
  }
}
