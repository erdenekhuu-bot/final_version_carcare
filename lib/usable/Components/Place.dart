import 'package:final_pro/usable/Components/OfferPlace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_pro/REST/RESTAPI.dart';

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
    TextEditingController _cnt1 = TextEditingController();
    TextEditingController _cnt2 = TextEditingController();
    TextEditingController _cnt3 = TextEditingController();
    TextEditingController _cnt4 = TextEditingController();
    TextEditingController _ctn5 = TextEditingController();
    List<dynamic> _shops = [];

    @override
    void dispose() {
      super.dispose();
      _cnt1.dispose();
      _cnt2.dispose();
      _cnt3.dispose();
      _cnt4.dispose();
      _ctn5.dispose();
    }

    @override
    void initState(){
      super.initState();
      getShops();
    }
    void getShops() async {
      List<dynamic> result = await RESTAPI.getPlaces();
      setState(() {
         _shops=result;
      });
    }
    List<dynamic> _filteredShops = [];
    void _filterShops(String query) {
      query = query.toLowerCase();
      setState(() {
        if (query.isEmpty) {
          _filteredShops = List.from(_shops);
        }
        else {
          _filteredShops = _shops.where((shop) {
            return shop['name'].toLowerCase().contains(query);
          }).toList();
        }
      });
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
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 40, left: 40),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              onChanged: _filterShops,
                              controller: _cnt1,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), // Set border radius here
                                  borderSide: BorderSide.none),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                hintText: 'Хайх...',
                                hintStyle: TextStyle(color: const Color(0xFF404040).withOpacity(0.5),
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
                              children: _filteredShops.map((shop) {
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
                              controller: _cnt2,
                              onChanged: _filterShops,
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
                              children: _filteredShops.map((shop) {
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
                              controller: _cnt3,
                              onChanged: _filterShops,
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
                              children: _filteredShops.map((shop) {
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
                              controller: _cnt4,
                              onChanged: _filterShops,
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
                              children: _filteredShops.map((shop) {
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
                              controller: _ctn5,
                              onChanged: _filterShops,
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
                              children: _filteredShops.map((shop) {
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
                  ],
                ),
              ),
            );
          }));
    }
}
