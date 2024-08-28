import'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'HomePage/Home.dart';
import 'Map/Map.dart';
import 'Car/Car.dart';
import 'User/User.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:final_pro/usable/Components/StyleBottomNavBar.dart';
import 'package:final_pro/REST/AuthService.dart';
import 'package:final_pro/usable/Components/Helper.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}
late PersistentTabController _controller;
List<dynamic> shops = [];
List<dynamic> services=[];
List<dynamic> subdir=[];
List<dynamic> category=[];
List<dynamic> defaultShop=[];
List<LatLng> defaultAddress=[];

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    getShops();
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  void getShops() async {
    String? access=await Helper.readDefaultToken();
    String? refresh=await Helper.readToken();
    AuthService authService = AuthService(access!, refresh!);
    List<dynamic> result = await authService.fetchAllShops();
    List<dynamic> defaultResult = await authService.fetchAllShops();
    List<dynamic> serviceResult = await authService.getServices();
    List<dynamic> other=await authService.serviceSubDir();
    setState(() {
      shops=result;
      defaultShop=defaultResult;
    });
    Store.filterSubdirServices=other;
    Store.filterServices=serviceResult;
  }

  void reset() async {
    String? access=await Helper.readDefaultToken();
    String? refresh=await Helper.readToken();
    AuthService authService = AuthService(access!, refresh!);
    List<LatLng> customA=[];
    List<dynamic> customShops=await authService.fetchAllShops();
    for (var item in customShops) {
      customA.add(LatLng(
          item['shop']['shop_location']['latitude'], item['shop']['shop_location']['longitude']));
    }
  }
  void switchToMaps(List<LatLng> places, List<dynamic> newShops) {
    setState(() {
      defaultAddress.clear();
      defaultAddress.addAll(places);
      shops.clear();
      shops.addAll(newShops);
    });
    _controller.jumpToTab(1);
  }

  @override
  Widget build(BuildContext context) {
    Store.filterShops=[];
    Store.filterAddress=[];
    List<LatLng> shopAddress=[];
    for (var item in shops) {
      shopAddress.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));

    }
    for(int i=0; i<defaultShop.length; i++){
      Store.filterShops.add(defaultShop[i]);
      Store.filterAddress.add(LatLng(defaultShop[i]['shop_location']['latitude'], defaultShop[i]['shop_location']['longitude']));
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PersistentTabView(
        controller: _controller,
        navBarHeight: kBottomNavigationBarHeight,
        tabs: [
          PersistentTabConfig(
              screen: Home(controller: _controller, onNavigateToMaps: switchToMaps),
              item: ItemConfig(
                  inactiveIcon: SvgPicture.asset('images/home.svg'),
                  icon: SvgPicture.asset('images/home.svg', color: Colors.black))),
          PersistentTabConfig(
              screen: Maps(key: UniqueKey(), places: shopAddress, shops: shops, servicePlaces: Store.filterServices, subdir: Store.filterSubdirServices),
              item: ItemConfig(
                  inactiveIcon: SvgPicture.asset('images/maps.svg'),
                  icon: SvgPicture.asset('images/maps.svg', color: Colors.black))),
          PersistentTabConfig(
            screen: Car(),
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

