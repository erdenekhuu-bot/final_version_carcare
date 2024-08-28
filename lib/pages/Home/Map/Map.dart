import 'dart:async';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/usable/MapComponents/map_helper.dart';
import 'package:final_pro/usable/MapComponents/map_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/MapComponents/MapMenu.dart';
import 'package:final_pro/usable/MapComponents/MapPlaceWindow.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/REST/AuthService.dart';
import 'package:final_pro/usable/Components/Helper.dart';

class Maps extends StatefulWidget {
  List<LatLng>? places;
  List<dynamic>? shops;
  List<dynamic>? subdir;
  final String? title;
  List<dynamic>? servicePlaces;
  int? forward = 0;
  String? name;
  Maps({super.key, this.name, this.forward, this.places, this.shops, this.title, this.servicePlaces, this.subdir});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  late GoogleMapController GoogleMapcontroller;
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = Set();
  final int _minClusterZoom = 0;
  final int _maxClusterZoom = 19;
  Fluster<MapMarker>? _clusterManager;
  double _currentZoom = 10;
  bool _isMapLoading = true;
  bool _areMarkersLoading = true;
  final String _markerImageUrl = 'https://img.icons8.com/office/80/000000/marker.png';
  final Color _clusterColor = Colors.black;
  final Color _clusterTextColor = Colors.white;

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    GoogleMapcontroller = controller;

    setState(() {
      _isMapLoading = false;
    });

    _initMarkers();
  }

  void _resetToDefault() {
      widget.places = Store.filterAddress;
      widget.shops =  Store.filterShops;
    _initMarkers();
    print('places ---> ${widget.places!.length}');
    print('shops ===> ${widget.shops!.length}');
  }

  void _initMarkers() async {
    final List<MapMarker> markers = [];
    for (int i = 0; i < widget.places!.length && i < widget.shops!.length; i++) {
      dynamic markerLocation = widget.places![i];
      dynamic shopData = widget.shops![i];
      final BitmapDescriptor markerImage = await MapHelper.getMarkerImageFromUrl(_markerImageUrl, targetWidth: 120);
      markers.add(
        MapMarker(
            id: i.toString(),
            position: markerLocation,
            icon: markerImage,
            onTap: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return MapPlaceWindow(
                      phone: shopData['phone'],
                      description: shopData['description'],
                      img: shopData['thumbnail'],
                      name: shopData['name'],
                      id: shopData['id']);
                },
              );
            }),
      );
    }

    _clusterManager = await MapHelper.initClusterManager(
        markers, _minClusterZoom, _maxClusterZoom);

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
        _clusterManager, _currentZoom, _clusterColor, _clusterTextColor, 100);

    _markers
      ..clear()
      ..addAll(updatedMarkers);

    setState(() {
      _areMarkersLoading = false;
    });
  }

  bool _firstClick = false;
  bool _secondClick = false;
  String defaultTitle = 'Бүгд';
  bool _next=false;

  @override
  void dispose() {
    super.dispose();
    GoogleMapcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: _isMapLoading ? 0 : 1,
          child: GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
                target: const LatLng(47.9221, 106.9155), zoom: _currentZoom),
            markers: Set<Marker>.of(_markers),
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
                child: const Padding(padding: EdgeInsets.all(4), child: Text('Түр хүлээнэ үү', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        if(widget.forward == 1)
              Positioned(
                top: 40,
                left: 20,
                child: Container(
                  width: screenWidth * 0.4,
                  height: 53,
                  decoration: BoxDecoration(
                    color: _firstClick ? const Color(0xff404040).withOpacity(0.8) : const Color.fromARGB(255, 112, 112, 112).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${widget.name}', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
          else if(widget.forward == 2)
             Text('')
          else
              Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _firstClick = !_firstClick;
                        _secondClick = false;
                         _next=true;
                      });
                      if (_next == true) _resetToDefault();
                    },
                    child: Container(
                      width: screenWidth * 0.4,
                      height: 53,
                      decoration: BoxDecoration(
                        color: _firstClick ? const Color(0xff404040).withOpacity(0.8) : const Color.fromARGB(255, 112, 112, 112).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('${_firstClick ? defaultTitle : defaultTitle = 'Бүгд'}', style: const TextStyle(color: Colors.white)),
                              _firstClick ? const Icon(Icons.arrow_drop_down_outlined, color: Colors.white) : const Icon(Icons.arrow_drop_up_outlined, color: Colors.white)
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
        _firstClick
            ? Positioned(
                top: 110,
                left: 20,
                child: Column(
                  children: [
                    for (var item in widget.servicePlaces!)
                      GestureDetector(
                        onTap: () async {
                          String? access=await Helper.readDefaultToken();
                          String? refresh=await Helper.readToken();
                          AuthService authService = AuthService(access!, refresh!);
                          List<LatLng> customA = [];
                          List<dynamic> customShops =
                              await authService.getCustomServices(item['name']);
                          for (var item in customShops) {
                            customA.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));
                          }
                          setState(() {
                            defaultTitle = item['name'];
                          });
                          widget.places = customA;
                          widget.shops = customShops;
                          _initMarkers();
                          _secondClick = true;
                        },
                        child: Column(
                          children: [
                            ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 450),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      MapFirstMenu(name: item['name'])
                                    ],
                                  ),
                                ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              )
            : const Text(''),
        _firstClick ? Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                   _secondClick = !_secondClick;
                });
              },
              child: Container(
                width: screenWidth * 0.4,
                height: 53,
                decoration: BoxDecoration(
                  color: const Color(0xff404040).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Үйлчилгээ', style: const TextStyle(color: Colors.white)),
                        _secondClick ? const Icon(Icons.arrow_drop_down_outlined, color: Colors.white) : Text('')
                      ],
                    ),
                  ],
                ),
              ),
            )) : Text(''),
        _secondClick
            ? Positioned(
                top: 110,
                right: 20,
                child: Column(
                  children: [
                    Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 450),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                        for (int i = 0; i < widget.subdir!.length; i++)
                                          if (widget.subdir![i]['category']['name'] == defaultTitle)
                                              GestureDetector(
                                                onTap: () async {
                                                  String? access=await Helper.readDefaultToken();
                                                  String? refresh=await Helper.readToken();
                                                  AuthService authService = AuthService(access!, refresh!);
                                                  List<LatLng> customB = [];
                                                  List<dynamic> customShopsB = await authService.getCustomServices(widget.subdir![i]['service']['name']);
                                                    for (var item in customShopsB) {
                                                      customB.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));
                                                    }
                                                    widget.places = customB;
                                                    widget.shops = customShopsB;
                                                  _initMarkers();
                                                },
                                                child: MapSecondMenu(name: widget.subdir![i]['service']['name']),
                                              )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                  ],
                ),
              )
            : const Text('')
      ],
    );
  }
}

