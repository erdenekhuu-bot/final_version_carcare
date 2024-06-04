import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clustering_google_maps/clustering_google_maps.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  @override
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(47.9221, 106.9155), zoom: 8));
  }
}
