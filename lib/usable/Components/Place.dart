import '../Components/OfferPlace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Place extends StatefulWidget {
  const Place({super.key});

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  List<Tab> tabs = <Tab>[
    Tab(
        child: Text(
      'Бүгд',
      style: TextStyle(fontSize: 12, color: Colors.black),
    )),
    Tab(
      child: Text(
        'Оношилгоо',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ),
    Tab(
      child: Text(
        'Аргерат',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ),
    Tab(
      child: Text(
        'Кузов',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ),
    Tab(
      child: Text(
        'Дугуй',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ),
    Tab(
      child: Text(
        'Угаалга',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    )
  ];

  List<dynamic> _shops = [];

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 243, 242, 242),
            appBar: AppBar(
              title: const Text(
                'Санал болгож буй газрууд',
                style: TextStyle(fontFamily: 'Inter', fontSize: 15),
              ),
              backgroundColor: const Color.fromARGB(255, 243, 242, 242),
              leading: IconButton(
                icon: SvgPicture.asset(
                  'images/iconBack.svg',
                  width: 35,
                  height: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: TabBar(
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: Colors.black,
                  tabs: tabs),
            ),
            body: SafeArea(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set border radius here
                                borderSide: BorderSide
                                    .none, // Optional, remove the default border
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Хайх...',
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xFF404040).withOpacity(0.5),
                                  fontSize: 15,
                                  height: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'images/search.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: _shops.map((shop) {
                              return OfferPlace(
                                title: shop['name'],
                                phone: shop['phone'],
                                img: shop['thumbnail'],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set border radius here
                                borderSide: BorderSide
                                    .none, // Optional, remove the default border
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Хайх...',
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xFF404040).withOpacity(0.5),
                                  fontSize: 15,
                                  height: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'images/search.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: _shops.map((shop) {
                              return OfferPlace(
                                title: shop['name'],
                                phone: shop['phone'],
                                img: shop['thumbnail'],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set border radius here
                                borderSide: BorderSide
                                    .none, // Optional, remove the default border
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Хайх...',
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xFF404040).withOpacity(0.5),
                                  fontSize: 15,
                                  height: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'images/search.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: _shops.map((shop) {
                              if (shop['type'] == 'REPAIR') {
                                return OfferPlace(
                                  title: shop['name'],
                                  phone: shop['phone'],
                                  img: shop['thumbnail'],
                                );
                              }
                              return SizedBox.shrink();
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set border radius here
                                borderSide: BorderSide
                                    .none, // Optional, remove the default border
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Хайх...',
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xFF404040).withOpacity(0.5),
                                  fontSize: 15,
                                  height: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'images/search.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: _shops.map((shop) {
                              if (shop['type'] == 'KUZOV') {
                                return OfferPlace(
                                  title: shop['name'],
                                  phone: shop['phone'],
                                  img: shop['thumbnail'],
                                );
                              }
                              return SizedBox.shrink();
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set border radius here
                                borderSide: BorderSide
                                    .none, // Optional, remove the default border
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Хайх...',
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xFF404040).withOpacity(0.5),
                                  fontSize: 15,
                                  height: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'images/search.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: _shops.map((shop) {
                              if (shop['type'] == 'TIRE') {
                                return OfferPlace(
                                  title: shop['name'],
                                  phone: shop['phone'],
                                  img: shop['thumbnail'],
                                );
                              }
                              return SizedBox.shrink();
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set border radius here
                                borderSide: BorderSide
                                    .none, // Optional, remove the default border
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Хайх...',
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xFF404040).withOpacity(0.5),
                                  fontSize: 15,
                                  height: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'images/search.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: _shops.map((shop) {
                              if (shop['type'] == 'CLEANING') {
                                return OfferPlace(
                                  title: shop['name'],
                                  phone: shop['phone'],
                                  img: shop['thumbnail'],
                                );
                              }
                              return SizedBox.shrink();
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
