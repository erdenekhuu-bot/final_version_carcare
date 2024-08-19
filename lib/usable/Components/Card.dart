import 'package:final_pro/pages/Home/Map/Map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/Store/Store.dart';

class Cart extends StatefulWidget {
  final String txt;
  final String? img;
  final void Function(List<LatLng>, List<dynamic>) onNavigateToMap;
  const Cart({super.key, this.img, required this.txt, required this.onNavigateToMap});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<dynamic> customShops = [];
  List<LatLng> customAddress = [];
  List<dynamic> customize = [];

  Future<void> takeShops() async {
    customShops = [];
    try {
      List<dynamic> result = [];
      switch (widget.txt) {
        case 'Агрегат':
          result = await RESTAPI.getCustomServices('Агрегат');
          break;
        case 'Кузов':
          result = await RESTAPI.getCustomServices('Кузов');
          break;
        case 'Дугуй':
          result = await RESTAPI.getCustomServices('Дугуй');
          break;
        case 'Угаалга':
          result = await RESTAPI.getCustomServices('Угаалга');
          break;
        case 'Мотоцикл':
          result = await RESTAPI.getCustomServices('Мотоцикл');
          break;
        case 'Машин худалдаа':
          result = await RESTAPI.getCustomServices('Машин худалдаа');
          break;
        case 'Сэлбэг худалдаа':
          result = await RESTAPI.getCustomServices('Сэлбэг худалдаа');
          break;
        case 'Авто будаг':
          result = await RESTAPI.getCustomServices('Авто будаг');
          break;
        case 'Авто шил':
          result = await RESTAPI.getCustomServices('Авто шил');
          break;
        case 'Хуулга':
          result = await RESTAPI.getCustomServices('Хуулга');
          break;
        case 'Суудлын бүрээс':
          result = await RESTAPI.getCustomServices('Суудлын бүрээс');
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
        Store.storeShopName=item['name'];
        customAddress.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));
      } catch(error){}
    return GestureDetector(
      onTap: () {
        takeShops().then((_) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Maps(shops: customShops, places: customAddress, forward: 1, name: widget.txt)),
          // );
          widget.onNavigateToMap(customAddress, customShops);
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
  final void Function(List<LatLng>, List<dynamic>) onNavigateToMap;
  const Cart2({super.key, required this.img, required this.txt, required this.onNavigateToMap});

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
          result = await RESTAPI.getCustomServices('Агрегат');
          break;
        case 'Кузов':
          result = await RESTAPI.getCustomServices('Кузов');
          break;
        case 'Дугуй':
          result = await RESTAPI.getCustomServices('Дугуй');
          break;
        case 'Угаалга':
          result = await RESTAPI.getCustomServices('Угаалга');
          break;
        case 'Мотоцикл':
          result = await RESTAPI.getCustomServices('Мотоцикл');
          break;
        case 'Машин худалдаа':
          result = await RESTAPI.getCustomServices('Машин худалдаа');
          break;
        case 'Сэлбэг худалдаа':
          result = await RESTAPI.getCustomServices('Сэлбэг худалдаа');
          break;
        case 'Авто будаг':
          result = await RESTAPI.getCustomServices('Авто будаг');
          break;
        case 'Авто шил':
          result = await RESTAPI.getCustomServices('Авто шил');
          break;
        case 'Хуулга':
          result = await RESTAPI.getCustomServices('Хуулга');
          break;
        case 'Суудлын бүрээс':
          result = await RESTAPI.getCustomServices('Суудлын бүрээс');
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
        Store.storeShopName=item['name'];
        customAddress.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));
      } catch(error){
        print(error);
      }
    return GestureDetector(
      onTap: () async {
        takeShops().then((_) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Maps(shops: customShops, places: customAddress, forward: 1, name: widget.txt)),
          // );
          widget.onNavigateToMap(customAddress, customShops);
        });
      },
      child: Padding(
        padding: EdgeInsets.all(screenWidth / 120),
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
      )
    );
  }
}


