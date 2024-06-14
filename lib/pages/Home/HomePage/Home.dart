import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/usable/Components/SWZasvar.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_pro/usable/Components/BackgroundImage.dart';
import 'package:final_pro/usable/Components/Swapping.dart';
import 'package:final_pro/usable/Components/Card.dart';
import 'package:final_pro/usable/Components/OfferPlace.dart';
import 'package:final_pro/usable/Components/Place.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {

  final List<dynamic>? services;
  Home({super.key, this.services});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = ['images/RectangleEdited.png', 'images/RectangleEdited.png'];
  List<dynamic> shops = [];
  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 8, activeDotColor: Color(0xFF404040), dotHeight: 8),
        activeIndex: activeIndex,
        count: urlImages.length,
      );
  void animateToSlide(int index) => controller.animateToPage(index);

  @override
  void initState() {
    super.initState();
    getShops();
  }

  String filter(String phone){
    if(phone.length == 7){
      return phone.substring(0,7);
    }
    else {
      return phone.substring(0,8);
    }
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = urlImages[index];
                      return Container(
                        child: buildImage(urlImage, index),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                buildIndicator(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: null,
                          child: const Text('Үйлчилгээ',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter'))),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Swapping();
                              });
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
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            for(var item in widget.services!)
                                Cart(img: item['iconAsset']['path'], txt: item['name'])
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            MaterialPageRoute(
                                builder: (context) => Place(shop: shops,)),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                       for(int i=0; i<shops.length; i++)
                          if(i<10)
                            OfferPlace(title: shops[i]['name'], phone: filter(shops[i]['phone']), img: shops[i]['thumbnail'],)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
