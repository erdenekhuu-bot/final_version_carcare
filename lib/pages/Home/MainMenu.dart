import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'HomePage/Home.dart';
import 'Map/Map.dart';
import 'Car/Car.dart';
import 'User/User.dart';
import '../../usable/Components/StyleBottomNavBar.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

List<dynamic> shops = [];

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
    getShops();
  }

  void getShops() async {
    List<dynamic> result = await RESTAPI.getPlaces();
    setState(() {
      shops = result;
    });
  }

  List<LatLng> customAddress = [];

  @override
  Widget build(BuildContext context) {
    for (var item in shops) {
      if (item['location'] != null) {
        customAddress.add(LatLng(
            item['location']['latitude'], item['location']['longitude']));
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PersistentTabView(
        navBarHeight: 70,
        tabs: [
          PersistentTabConfig(
              screen: const Home(),
              item: ItemConfig(
                  inactiveIcon: SvgPicture.asset('images/home.svg'),
                  icon: SvgPicture.asset('images/home.svg',
                      color: Colors.black))),
          PersistentTabConfig(
              screen: Maps(places: customAddress),
              item: ItemConfig(
                  inactiveIcon: SvgPicture.asset('images/maps.svg'),
                  icon: SvgPicture.asset('images/maps.svg',
                      color: Colors.black))),
          PersistentTabConfig(
            screen: const Car(),
            item: ItemConfig(
              icon: Image.asset('images/car_black.png'),
              inactiveIcon: Image.asset(
                'images/car.png',
              ),
            ),
          ),
          PersistentTabConfig(
              screen: const User(),
              item: ItemConfig(
                  inactiveIcon: SvgPicture.asset('images/user.svg'),
                  icon: SvgPicture.asset('images/user.svg',
                      color: Colors.black))),
        ],
        navBarBuilder: (navBarConfig) =>
            StyleBottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
