import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/REST/AuthService.dart';
import 'package:final_pro/usable/Components/Helper.dart';

class Cart extends StatefulWidget {
  final String txt;
  final String? img;
  final void Function(List<LatLng>, List<dynamic>) onNavigateToMap;
  Cart({super.key, this.img, required this.txt, required this.onNavigateToMap});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<dynamic> customShops = [];
  List<LatLng> customAddress = [];
  List<dynamic> customize = [];

  Future<void> takeShops() async {
    String? access=await Helper.readDefaultToken();
    String? refresh=await Helper.readToken();
    AuthService authService = AuthService(access!, refresh!);
    customShops = [];
    try {
      List<dynamic> result = [];
      switch (widget.txt) {
        case 'Агрегат':
          result = await authService.getCustomServices('Агрегат');
          break;
        case 'Кузов':
          result = await authService.getCustomServices('Кузов');
          break;
        case 'Дугуй':
          result = await authService.getCustomServices('Дугуй');
          break;
        case 'Угаалга':
          result = await authService.getCustomServices('Угаалга');
          break;
        case 'Мотоцикл':
          result = await authService.getCustomServices('Мотоцикл');
          break;
        case 'Машин худалдаа':
          result = await authService.getCustomServices('Машин худалдаа');
          break;
        case 'Сэлбэг худалдаа':
          result = await authService.getCustomServices('Сэлбэг худалдаа');
          break;
        case 'Авто будаг':
          result = await authService.getCustomServices('Авто будаг');
          break;
        case 'Авто шил':
          result = await authService.getCustomServices('Авто шил');
          break;
        case 'Хуулга':
          result = await authService.getCustomServices('Хуулга');
          break;
        case 'Суудлын бүрээс':
          result = await authService.getCustomServices('Суудлын бүрээс');
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
    customAddress=[];
    for(var item in customShops)
      try {
        Store.storeShopName=item['name'];
        customAddress.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));
      } catch(error){}
    return GestureDetector(
      onTap: () {
        takeShops().then((_) {
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
  Cart2({super.key, required this.img, required this.txt, required this.onNavigateToMap});

  @override
  State<Cart2> createState() => _Cart2State();
}

class _Cart2State extends State<Cart2> {

  List<dynamic> customShops = [];


  Future<void> takeShops() async {
    String? access=await Helper.readDefaultToken();
    String? refresh=await Helper.readToken();
    AuthService authService = AuthService(access!, refresh!);
    customShops = [];
    try {
      List<dynamic> result = [];
      switch (widget.txt) {
        case 'Агрегат':
          result = await authService.getCustomServices('Агрегат');
          break;
        case 'Кузов':
          result = await authService.getCustomServices('Кузов');
          break;
        case 'Дугуй':
          result = await authService.getCustomServices('Дугуй');
          break;
        case 'Угаалга':
          result = await authService.getCustomServices('Угаалга');
          break;
        case 'Мотоцикл':
          result = await authService.getCustomServices('Мотоцикл');
          break;
        case 'Машин худалдаа':
          result = await authService.getCustomServices('Машин худалдаа');
          break;
        case 'Сэлбэг худалдаа':
          result = await authService.getCustomServices('Сэлбэг худалдаа');
          break;
        case 'Авто будаг':
          result = await authService.getCustomServices('Авто будаг');
          break;
        case 'Авто шил':
          result = await authService.getCustomServices('Авто шил');
          break;
        case 'Хуулга':
          result = await authService.getCustomServices('Хуулга');
          break;
        case 'Суудлын бүрээс':
          result = await authService.getCustomServices('Суудлын бүрээс');
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
    List<LatLng> customAddress = [];
    double screenWidth = MediaQuery.of(context).size.width;
    for(var item in customShops)
      try {
        customAddress.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));
      } catch(error){

      }
    return GestureDetector(
      onTap: () async {
        takeShops().then((_) {
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


