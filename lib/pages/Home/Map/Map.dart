import 'dart:async';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/usable/MapComponents/map_helper.dart';
import 'package:final_pro/usable/MapComponents/map_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final List<LatLng> places;
  Maps({super.key, required this.places});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = Set();
  final int _minClusterZoom = 0;
  final int _maxClusterZoom = 19;
  Fluster<MapMarker>? _clusterManager;
  double _currentZoom = 10;
  bool _isMapLoading = true;
  bool _areMarkersLoading = true;
  final String _markerImageUrl =
      'https://img.icons8.com/office/80/000000/marker.png';
  final Color _clusterColor = Colors.blue;
  final Color _clusterTextColor = Colors.white;
  // final List<LatLng> _markerLocations = [
  //   LatLng(41.147125, -8.611249),
  //   LatLng(41.145599, -8.610691),
  //   LatLng(41.145645, -8.614761),
  //   LatLng(41.146775, -8.614913),
  //   LatLng(41.146982, -8.615682),
  //   LatLng(41.140558, -8.611530),
  //   LatLng(41.138393, -8.608642),
  //   LatLng(41.137860, -8.609211),
  //   LatLng(41.138344, -8.611236),
  //   LatLng(41.139813, -8.609381),
  // ];

  // final List<LatLng> _markerLocations = Store.location;

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    setState(() {
      _isMapLoading = false;
    });

    _initMarkers();
  }

  void _initMarkers() async {
    final List<MapMarker> markers = [];

    for (LatLng markerLocation in widget.places) {
      final BitmapDescriptor markerImage =
          await MapHelper.getMarkerImageFromUrl(_markerImageUrl);

      markers.add(
        MapMarker(
          id: widget.places.indexOf(markerLocation).toString(),
          position: markerLocation,
          icon: markerImage,
        ),
      );
    }

    _clusterManager = await MapHelper.initClusterManager(
      markers,
      _minClusterZoom,
      _maxClusterZoom,
    );

    await _updateMarkers();
  }

  Future<void> _updateMarkers([double? updatedZoom]) async {
    if (_clusterManager == null || updatedZoom == _currentZoom) return;

    if (updatedZoom != null) {
      _currentZoom = updatedZoom;
    }

    setState(() {
      _areMarkersLoading = true;
    });

    final updatedMarkers = await MapHelper.getClusterMarkers(
      _clusterManager,
      _currentZoom,
      _clusterColor,
      _clusterTextColor,
      80,
    );

    _markers
      ..clear()
      ..addAll(updatedMarkers);

    setState(() {
      _areMarkersLoading = false;
    });
  }

  bool _firstClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: _isMapLoading ? 0 : 1,
            child: GoogleMap(
              mapToolbarEnabled: true,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                // target: LatLng(47.9221, 106.9155),
                target: LatLng(47.9221, 106.9155),
                zoom: _currentZoom,
              ),
              markers: _markers,
              onMapCreated: (controller) => _onMapCreated(controller),
              onCameraMove: (position) => _updateMarkers(position.zoom),
            ),
          ),
          Opacity(
            opacity: _isMapLoading ? 1 : 0,
            child: Center(child: CircularProgressIndicator()),
          ),
          if (_areMarkersLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 2,
                  color: Colors.grey.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Түр хүлээнэ үү',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 152
                  : 252,
              height: 53,
              decoration: BoxDecoration(
                color: _firstClick
                    ? const Color(0xff404040).withOpacity(0.8)
                    : const Color.fromARGB(255, 112, 112, 112).withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _firstClick = !_firstClick;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Бүгд', style: TextStyle(color: Colors.white)),
                        _firstClick
                            ? const Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.arrow_drop_up_outlined,
                                color: Colors.white,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
