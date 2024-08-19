import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'HomePage/Home.dart';
import 'Map/Map.dart';
import 'Car/Car.dart';
import 'User/User.dart';
//import 'package:final_pro/usable/Components/StyleBottomNavBar.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/usable/Components/Global_controller.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

List<dynamic> shops = [];

List<LatLng> addressFetch=[];
List<dynamic> shopsFetch=[];

List<Widget> _screens = [];

class _MainMenuState extends State<MainMenu> {

  @override
  void initState() {
    getShops();
    _updateScreens();
    super.initState();
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


  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _updateScreens() {
    _screens = [
      Home(onNavigateToMap: _navigateToMap),
      Maps(
        key: UniqueKey(),
        places: addressFetch,
        shops: shopsFetch,
        servicePlaces: Store.filterServices,
        subdir: Store.filterSubdirServices,
      ),
      const Car(),
      const User(),
    ];
  }

  void _navigateToMap(List<LatLng> filteringAddress, List<dynamic> filterShopping) async {
    final List<LatLng> newAddressFetch = filteringAddress.isNotEmpty ? filteringAddress : Store.filterAddress;
    final List<dynamic> newShopsFetch = filterShopping.isNotEmpty ? filterShopping : Store.filterShops;

    setState(() {
      addressFetch = newAddressFetch;
      shopsFetch = newShopsFetch;
      _currentIndex = 1;
      _updateScreens();
    });
  }




  @override
  Widget build(BuildContext context) {
    Store.filterAddress=[];
    for (var item in shops) {
        Store.filterAddress.add(LatLng(item['shop_location']['latitude'], item['shop_location']['longitude']));
    }
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('images/home.svg'),
            activeIcon: SvgPicture.asset('images/home.svg', color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('images/maps.svg'),
            activeIcon: SvgPicture.asset('images/maps.svg', color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/car.png'),
            activeIcon: Image.asset('images/car_black.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('images/user.svg'),
            activeIcon: SvgPicture.asset('images/user.svg', color: Colors.black),
            label: '',
          ),
        ],
      ),
    );
  }
}
