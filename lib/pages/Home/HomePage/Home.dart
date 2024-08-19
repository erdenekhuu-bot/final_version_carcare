import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_pro/usable/Components/Swapping.dart';
import 'package:final_pro/usable/Components/Card.dart';
import 'package:final_pro/usable/Components/OfferPlace.dart';
import 'package:final_pro/usable/Components/Place.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Home extends StatefulWidget {
  final void Function(List<LatLng>, List<dynamic>) onNavigateToMap;
  Home({super.key, required this.onNavigateToMap});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;
  final controller = CarouselSliderController();
  List<dynamic> shops = [];
  List<dynamic> eachShops = [];

  List<dynamic> urlImages = [];
  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 8, activeDotColor: Color(0xFF404040), dotHeight: 8),
        activeIndex: activeIndex,
        count: urlImages.length,
      );
  void animateToSlide(int index) => controller.animateToPage(index);
  
  void callBanner() async {
    List<dynamic> images = await RESTAPI.takeBanner();
    List<dynamic> customFilter = [];
    for (var item in images) {
      customFilter.add(Store.filtering(item['thumbnail']));
    }
    setState(() {
      urlImages = customFilter;
    });
  }

  @override
  void initState() {
    getShops();
    callBanner();
    super.initState();
  }

  void getShops() async {
    List<dynamic> result = await RESTAPI.getPlaces();
    List<dynamic> cate = await RESTAPI.serviceSubCategory();
    Store.swappingCategory = cate;
    shops = result;
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                CarouselSlider.builder(
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = urlImages[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            urlImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                        height: 170,
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index))),
                const SizedBox(height: 3),
                buildIndicator(),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: null,
                          child: const Text('Үйлчилгээ',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'Inter'))),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Swapping(category: Store.filterServices, onNavigateToMap: widget.onNavigateToMap);
                            },
                          );
                        },
                        child: Container(
                            margin: null,
                            child: const Row(
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 1),
                                    child: Text('Бүгд',
                                        style: TextStyle(fontSize: 14))),
                                Icon(Icons.arrow_forward_ios_outlined, size: 15)
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                if (Store.filterServices.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.blue,
                              backgroundColor: Colors.white,
                            ),
                          ],
                        )),
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 351),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 18,
                            children: [
                              for (var item in Store.filterServices)
                                Cart(img: item['asset_path'], txt: item['name'], onNavigateToMap: widget.onNavigateToMap)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: null,
                          child: const Text('Санал болгож буй газрууд',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter'))),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Place(
                              onNavigateToMap: widget.onNavigateToMap,
                            )),
                          );
                        },
                        child: Container(
                            margin: null,
                            child: const Row(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1),
                                    child: Text('Бүгд',
                                        style: TextStyle(fontSize: 14))),
                                Icon(Icons.arrow_forward_ios_outlined, size: 15)
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (shops.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                    child: const Column(
                      children: [
                        CircularProgressIndicator(
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                    child: Column(
                      children: [
                        for (int i = 0; i < shops.length; i++)
                          if (i < 10)
                            OfferPlace(
                                title: shops[i]['name'],
                                phone: filter(shops[i]['phone']),
                                img: shops[i]['thumbnail'],
                                id: shops[i]['id'],
                                onNavigateToMap: widget.onNavigateToMap,
                            )
                      ],
                    ),
                  )
              ],
            ),
          ],
        ),
    );
  }
}