import 'dart:async';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/usable/MapComponents/map_helper.dart';
import 'package:final_pro/usable/MapComponents/map_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/MapComponents/MapMenu.dart';
class Maps extends StatefulWidget {
  final List<LatLng> places;

  final List<dynamic> shops;
  Maps({super.key, required this.places, required this.shops});

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
  final Color _clusterColor = Colors.black;
  final Color _clusterTextColor = Colors.white;
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    setState(() {
      _isMapLoading = false;
    });

    _initMarkers();
  }

  void _initMarkers() async {
    final List<MapMarker> markers = [];
    for (int i = 0; i < widget.places.length && i < widget.shops.length; i++) {
      dynamic markerLocation = widget.places[i];
      dynamic shopData = widget.shops[i];

      final BitmapDescriptor markerImage = await MapHelper.getMarkerImageFromUrl(shopData['thumbnail'], targetWidth: 150);

      markers.add(
        MapMarker(
          id: i.toString(),
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
  bool _secondClick = false;
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
                target: const LatLng(47.9221, 106.9155),
                zoom: _currentZoom,
              ),
              markers: Set<Marker>.of(_markers),
              onTap: (value){
                print('Marker tapped and -> $value');
              },
              onMapCreated: (controller) => _onMapCreated(controller),
              onCameraMove: (position) => _updateMarkers(position.zoom),
            ),
          ),
          Opacity(
            opacity: _isMapLoading ? 1 : 0,
            child: const Center(child: CircularProgressIndicator()),
          ),
          if (_areMarkersLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 2,
                  color: Colors.grey.withOpacity(0.9),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
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
                        const Text('Бүгд',
                            style: TextStyle(color: Colors.white)),
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
          _firstClick
              ? Positioned(
                  top: 110,
                  left: 20,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: null,
                        child: const MapFirstMenu(name: 'Агрегат засвар'),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: const MapFirstMenu(name: 'Кузов засвар'),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: const MapFirstMenu(name: 'Угаалга'),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: const MapFirstMenu(name: 'Машин худалдаа'),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: const MapFirstMenu(name: 'Сэлбэг худалдаа'),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: const MapFirstMenu(name: 'Дугуй'),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: const MapFirstMenu(name: 'Машин будаг'),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: const MapFirstMenu(name: 'Мотоцикл'),
                      )
                    ],
                  ))
              : const Text(''),

          _secondClick
              ? Positioned(
                  top: 110,
                  right: 20,
                  child: Column(children: [
                      GestureDetector(
                        onTap: null,
                        child: const MapSecondMenu(name: 'Тос солих'),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: const MapSecondMenu(name: 'Оношилгоо'),),
                      GestureDetector(
                        onTap: null,
                        child: const MapSecondMenu(name: 'Тос тосолгоо'),),
                      GestureDetector(onTap: null,
                        child: const MapSecondMenu(name: 'Амартизатор'),),
                      GestureDetector(onTap: null,
                        child: const MapSecondMenu(name: 'Аккумлятор'),),
                      GestureDetector(onTap: null,
                        child: const MapSecondMenu(name: 'Тэнхлэг тохиргоо'),),
                      GestureDetector(onTap: null,
                        child: const MapSecondMenu(name: 'Мотор засвар'),),
                      GestureDetector(onTap: null,
                        child: const MapSecondMenu(name: 'Явах эд анги'),),
                      GestureDetector(onTap: null,
                        child: const MapSecondMenu(name: 'Компьютер оношилгоо'),),
                      GestureDetector(onTap: null,
                        child: const MapSecondMenu(name: 'Эйр кондейшн'),),
                      GestureDetector(onTap: null,
                        child: const MapSecondMenu(name: 'Наклад тормос'),)
                  ]),
                )
              : const Text(''),
        ],
      ),
    );
  }
}
