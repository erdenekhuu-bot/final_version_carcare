import 'package:final_pro/pages/Home/Map/Map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/Store/Store.dart';

class Cart extends StatefulWidget {
  final String txt;
  final String? img;
  const Cart({super.key, this.img, required this.txt});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<dynamic> customShops = [];
  List<LatLng> customAddress = [];

  Future<void> takeShops() async {
    customShops = [];
    try {
      List<dynamic> result = [];
      switch (widget.txt) {
        case 'Агрегат':
          result = await RESTAPI.getCustomPlaces('Агрегат');
          break;
        case 'Кузов':
          result = await RESTAPI.getCustomPlaces('Кузов');
          break;
        case 'Дугуй':
          result = await RESTAPI.getCustomPlaces('Дугуй');
          break;
        case 'Угаалга':
          result = await RESTAPI.getCustomPlaces('Угаалга');
          break;
        case 'Мотоцикл':
          result = await RESTAPI.getCustomPlaces('Мотоцикл');
          break;
        case 'Машин худалдаа':
          result = await RESTAPI.getCustomPlaces('Машин худалдаа');
          break;
        case 'Сэлбэг худалдаа':
          result = await RESTAPI.getCustomPlaces('Сэлбэг худалдаа');
          break;
        case 'Авто будаг':
          result = await RESTAPI.getCustomPlaces('Авто будаг');
          break;
        case 'Авто шил':
          result = await RESTAPI.getCustomPlaces('Авто шил');
          break;
        case 'Хуулга':
          result = await RESTAPI.getCustomPlaces('Хуулга');
          break;
        case 'Суудлын бүрээс':
          result = await RESTAPI.getCustomPlaces('Суудлын бүрээс');
          break;
        default:
          break;
      }
      setState(() {
        customShops = result;
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    for(var item in customShops)
      try {
        Store.storeShopName=item['shop']['name'];
        customAddress.add(LatLng(item['shop']['shop_location']['latitude'], item['shop']['shop_location']['longitude']));
      } catch(error){
        print(error);
      }

    return GestureDetector(
      onTap: () {
        takeShops().then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Maps(shops: customShops, places: customAddress, forward: 1, name: widget.txt)),
          );
        });
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xff404040),
              borderRadius: BorderRadius.circular(60),
            ),
             child: SvgPicture.network('https://d3v7ghkqvtko5q.cloudfront.net/${widget.img}'),
          ),
          Text(widget.txt, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}


class Cart2 extends StatefulWidget {
  final String img;
  final String txt;

  const Cart2({super.key, required this.img, required this.txt});

  @override
  State<Cart2> createState() => _Cart2State();
}

class _Cart2State extends State<Cart2> {

  List<dynamic> customShops = [];
  List<LatLng> customAddress = [];

  Future<void> takeShops() async {
    customShops = [];
    try {
      List<dynamic> result = [];
      switch (widget.txt) {
        case 'Агрегат':
          result = await RESTAPI.getCustomPlaces('Агрегат');
          break;
        case 'Кузов':
          result = await RESTAPI.getCustomPlaces('Кузов');
          break;
        case 'Дугуй':
          result = await RESTAPI.getCustomPlaces('Дугуй');
          break;
        case 'Угаалга':
          result = await RESTAPI.getCustomPlaces('Угаалга');
          break;
        case 'Мотоцикл':
          result = await RESTAPI.getCustomPlaces('Мотоцикл');
          break;
        case 'Машин худалдаа':
          result = await RESTAPI.getCustomPlaces('Машин худалдаа');
          break;
        case 'Сэлбэг худалдаа':
          result = await RESTAPI.getCustomPlaces('Сэлбэг худалдаа');
          break;
        case 'Авто будаг':
          result = await RESTAPI.getCustomPlaces('Авто будаг');
          break;
        case 'Авто шил':
          result = await RESTAPI.getCustomPlaces('Авто шил');
          break;
        case 'Хуулга':
          result = await RESTAPI.getCustomPlaces('Хуулга');
          break;
        case 'Суудлын бүрээс':
          result = await RESTAPI.getCustomPlaces('Суудлын бүрээс');
          break;
        default:
          break;
      }
      setState(() {
        customShops = result;
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    for(var item in customShops)
      try {
        Store.storeShopName=item['shop']['name'];
        customAddress.add(LatLng(item['shop']['shop_location']['latitude'], item['shop']['shop_location']['longitude']));
      } catch(error){
        print(error);
      }
    return GestureDetector(
      onTap: () async {
        takeShops().then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Maps(shops: customShops, places: customAddress, forward: 1, name: widget.txt)),
          );
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: screenWidth / 80, left: screenWidth / 30, right: screenWidth / 30, top: screenWidth / 50),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 7, left: 7),
              alignment: Alignment.center,
              width: 63,
              height: 63,
              decoration: BoxDecoration(
                color: const Color(0xff404040),
                borderRadius: BorderRadius.circular(70),
              ),
              child: SvgPicture.network('https://d3v7ghkqvtko5q.cloudfront.net/${widget.img}'),
            ),
            SizedBox(
              width: 90,
              child: Text(
                widget.txt,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            )
          ],
        ),
      ),
    );
  }
}


