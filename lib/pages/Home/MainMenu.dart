import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'HomePage/Home.dart';
import 'Map/Map.dart';
import 'Car/Car.dart';
import 'User/User.dart';
import 'package:final_pro/usable/Components/StyleBottomNavBar.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/Store/Store.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

List<dynamic> shops = [];
List<dynamic> services=[];
List<dynamic> subdir=[];
List<dynamic> category=[];

class _MainMenuState extends State<MainMenu> {

  int currentPage=1;
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    getShops();
    refresh();
  }

  void refresh() async {
    String result=await RESTAPI.refreshToken();
    if(result != ''){
      Store.tempToken=result;
    }
  }

  void getShops() async {
    List<dynamic> result = await RESTAPI.fetchAllShops();
    List<dynamic> serviceResult = await RESTAPI.getServices();
    List<dynamic> other=await RESTAPI.serviceSubDir();
    setState(() {
      shops=result;
    });
    Store.filterShops=result;
    Store.filterSubdirServices=other;
    Store.filterServices=serviceResult;
  }

  List<LatLng> customAddress = [];

  void reset() async {
    List<LatLng> customA=[];
    List<dynamic> customShops=await RESTAPI.fetchAllShops();
    for (var item in customShops) {
      customA.add(LatLng(
          item['shop']['shop_location']['latitude'], item['shop']['shop_location']['longitude']));
    }
    Store.filterAddress=customA;
    Store.filterShops=customShops;
  }

  @override
  Widget build(BuildContext context) {
    for (var item in shops) {
        Store.filterAddress.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));
    }
    double screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PersistentTabView(
        navBarHeight: 70,
        tabs: [
          PersistentTabConfig(
              screen: Home(),
              item: ItemConfig(
                  inactiveIcon: SvgPicture.asset('images/home.svg'),
                  icon: SvgPicture.asset('images/home.svg',
                      color: Colors.black))),
          PersistentTabConfig(
              // screen: Maps(places: customAddress, shops: shops, servicePlaces: services, subdir: subdir, f1: (){},),
              screen: Maps(key: UniqueKey(), places: Store.filterAddress, shops: Store.filterShops, servicePlaces: Store.filterServices, subdir: Store.filterSubdirServices, f1: (){reset();}),
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
