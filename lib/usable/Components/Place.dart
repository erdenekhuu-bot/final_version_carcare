import 'package:final_pro/usable/Components/OfferPlace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place extends StatefulWidget {
  final void Function(List<LatLng>, List<dynamic>)? onNavigateToMap;
  Place({super.key, this.onNavigateToMap});

  @override
  State<Place> createState() => _PlaceState();
}

String filter(String phone) {
  if (phone.length == 7) {
    return phone.substring(0, 7);
  } else {
    return phone.substring(0, 8);
  }
}

class _PlaceState extends State<Place> {
  List<Tab> tabs = <Tab>[
    const Tab(child: Text('Бүгд', style: TextStyle(fontSize: 12, color: Colors.black))),
    const Tab(child: Text('Аргерат', style: TextStyle(fontSize: 12, color: Colors.black))),
    const Tab(child: Text('Кузов', style: TextStyle(fontSize: 12, color: Colors.black))),
    const Tab(child: Text('Дугуй', style: TextStyle(fontSize: 12, color: Colors.black))),
    const Tab(child: Text('Угаалга', style: TextStyle(fontSize: 12, color: Colors.black)))
  ];
  final TextEditingController _cnt1 = TextEditingController();
  final TextEditingController _cnt2 = TextEditingController();
  final TextEditingController _cnt3 = TextEditingController();
  final TextEditingController _cnt4 = TextEditingController();
  final TextEditingController _ctn5 = TextEditingController();

  bool isLoading = false;
  int currentPage = 1;
  ScrollController _scrollController = ScrollController();


  @override
  void dispose() {
    super.dispose();
    _cnt1.dispose();
    _cnt2.dispose();
    _cnt3.dispose();
    _cnt4.dispose();
    _ctn5.dispose();
    _scrollController.dispose();
  }

  List<dynamic> shop=[];
  List<dynamic> _filteredShops = [];

  @override
  void initState() {
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
    super.initState();
    //_filteredShops = List.from(shop);

  }
  
  
  void _filterShops(String query) {
    query = query.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredShops = List.from(shop);
      } else {
        _filteredShops = shop.where((shop) {
          return shop['name'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    final responseData = await RESTAPI.paginateShops(currentPage);
    if (responseData.isNotEmpty) {
      _filteredShops=shop;
      setState(() {
          shop.addAll(responseData);
          isLoading = false;
          currentPage++;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
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
              bottom: TabBar(labelPadding: EdgeInsets.zero, indicatorColor: Colors.black, tabs: tabs),
            ),
            body: TabBarView(
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
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set border radius here
                                  borderSide: BorderSide.none),
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
                      shop.isEmpty ? const Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.blue,
                                  backgroundColor: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ):Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: _filteredShops.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = _filteredShops[index];
                              return OfferPlace(
                                title: item['name'],
                                phone: filter(item['phone']),
                                img: item['thumbnail'],
                                id: item['id'],
                                onNavigateToMap: widget.onNavigateToMap!,
                              );
                            },
                          ),
                        ),
                      ),
                      if (isLoading)
                        const SizedBox(height: 5),
                        const CircularProgressIndicator(),
                        const SizedBox(height: 15),
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
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Хайх...',
                              hintStyle: TextStyle(
                                  color: const Color(0xFF404040).withOpacity(0.5),
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
                      shop.isEmpty ? const Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.blue,
                                  backgroundColor: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ) : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: _filteredShops.where((item) => item['type'] == 'REPAIR').length,
                            itemBuilder: (BuildContext context, int index) {
                              var repairShops = _filteredShops.where((item) => item['type'] == 'REPAIR').toList();
                              var item = repairShops[index];
                              return OfferPlace(
                                title: item['name'],
                                phone: filter(item['phone']),
                                img: item['thumbnail'],
                                id: item['id'],
                                  onNavigateToMap: widget.onNavigateToMap!
                              );
                            },
                          ),
                        ),
                      ),
                      if (isLoading)
                        const SizedBox(height: 5),
                        const CircularProgressIndicator(),
                        const SizedBox(height: 15),
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
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
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
                      shop.isEmpty ? const Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.blue,
                                  backgroundColor: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ) : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: _filteredShops.where((item) => item['type'] == 'KUZOV').length,
                            itemBuilder: (BuildContext context, int index) {
                              var repairShops = _filteredShops.where((item) => item['type'] == 'KUZOV').toList();
                              var item = repairShops[index];
                              return OfferPlace(
                                title: item['name'],
                                phone: filter(item['phone']),
                                img: item['thumbnail'],
                                id: item['id'],
                                  onNavigateToMap: widget.onNavigateToMap!
                              );
                            },
                          ),
                        ),
                      ),
                      if (isLoading)
                        const SizedBox(height: 5),
                        const CircularProgressIndicator(),
                        const SizedBox(height: 15),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 15),
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
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
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
                      const SizedBox(height: 5),
                     shop.isEmpty ? const Expanded(
                       child: SingleChildScrollView(
                         padding: EdgeInsets.symmetric(vertical: 10),
                         scrollDirection: Axis.vertical,
                         child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10),
                           child: Column(
                             children: [
                               CircularProgressIndicator(
                                 color: Colors.blue,
                                 backgroundColor: Colors.white,
                               )
                             ],
                           ),
                         ),
                       ),
                     ) : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: _filteredShops.where((item) => item['type'] == 'TIRE').length,
                            itemBuilder: (BuildContext context, int index) {
                              var repairShops = _filteredShops.where((item) => item['type'] == 'TIRE').toList();
                              var item = repairShops[index];
                              return OfferPlace(
                                title: item['name'],
                                phone: filter(item['phone']),
                                img: item['thumbnail'],
                                id: item['id'],
                                  onNavigateToMap: widget.onNavigateToMap!
                              );
                            },
                          ),
                        ),
                      ),
                      if (isLoading)
                        const SizedBox(height: 5),
                        const CircularProgressIndicator(),
                        const SizedBox(height: 15),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 15),
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
                                borderSide: BorderSide.none, // Optional, remove the default border
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Хайх...',
                              hintStyle: TextStyle(
                                  color: const Color(0xFF404040).withOpacity(0.5),
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
                      const SizedBox(height: 5),
                      shop.isEmpty ? const Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.blue,
                                  backgroundColor: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ) : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: _filteredShops.where((item) => item['type'] == 'CLEANING').length,
                            itemBuilder: (BuildContext context, int index) {
                              var repairShops = _filteredShops.where((item) => item['type'] == 'CLEANING').toList();
                              var item = repairShops[index];
                              return OfferPlace(
                                title: item['name'],
                                phone: filter(item['phone']),
                                img: item['thumbnail'],
                                id: item['id'],
                                  onNavigateToMap: widget.onNavigateToMap!
                              );
                            },
                          ),
                        ),
                      ),
                      if (isLoading)
                        const CircularProgressIndicator()
                    ],
                  ),
                ],
              ),
          );
        }));
  }
}
