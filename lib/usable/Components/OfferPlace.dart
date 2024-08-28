import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/REST/AuthService.dart';
import 'package:final_pro/usable/Components/Helper.dart';

class OfferPlace extends StatefulWidget {
  final int? id;
  final String img;
  final String title;
  final String phone;
  final void Function(List<LatLng>, List<dynamic>) onNavigateToMaps;
  OfferPlace({required this.img, required this.title, required this.phone, this.id, required this.onNavigateToMaps});

  @override
  State<OfferPlace> createState() => _OfferPlaceState();
}

class _OfferPlaceState extends State<OfferPlace> {
  List<dynamic> customShops = [];
  String startTime = '';
  String endTime = '';

  Future<void> eachPlaces() async {
    try {
      String? access=await Helper.readDefaultToken();
      String? refresh=await Helper.readToken();
      AuthService authService = AuthService(access!, refresh!);
      customShops = [];
      List<dynamic> result = await authService.eachPlaces(widget.id!);
      setState(() {
        customShops = result;
      });
    } catch (error) {
    }
  }

  @override
  void initState() {
    super.initState();
    eachPlaces();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<LatLng> customAddress = [];

    for (var item in customShops) {
      if (item['shop_location'] != null) {
        customAddress.add(LatLng(
          item['shop_location']['latitude'],
          item['shop_location']['longitude'],
        ));
      }
      if (item['shop_schedules'] is List<dynamic> && item['shop_schedules'] != null) {
        for (int i = 0; i < item['shop_schedules'].length; i++) {
          if (i < 1) {
            setState(() {
              startTime = item['shop_schedules'][i]['start_time'];
              endTime = item['shop_schedules'][i]['end_time'];
            });
          }
        }
      }
    }

    return GestureDetector(
      onTap: () {
        eachPlaces().then((_) {
          widget.onNavigateToMaps(customAddress, customShops);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            if (widget.img.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network('https://d3v7ghkqvtko5q.cloudfront.net/${widget.img}'),
                  ),
                ),
              )
            else
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(fontFamily: 'Inter-SemiBold', fontSize: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Даваа - Баасан', style: TextStyle(fontSize: 12, color: Color(0xff404040), fontFamily: 'Inter-Regular')),
                          Text('${Store.splitTime(startTime)} - ${Store.splitTime(endTime)}', style: const TextStyle(fontSize: 12, color: Color(0xff404040), fontFamily: 'Inter-Regular')),
                        ],
                      ),
                      SizedBox(width: screenWidth / 20),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.32,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffEDEDED),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset('images/phone.svg'),
                            Text('${Store.convertPhone(Store.Divide(widget.phone))}', style: const TextStyle(color: Color(0xff666666), fontFamily: 'Inter-Regular')),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}