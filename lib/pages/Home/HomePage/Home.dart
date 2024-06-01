import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../usable/Components/SWZasvar.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../usable/Components/BackgroundImage.dart';
import '../../../usable/Components/Swapping.dart';
import '../../../usable/Components/Card.dart';
import '../../../usable/Components/OfferPlace.dart';
import '../../../usable/Components/Place.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Tab> tabs = <Tab>[
    const Tab(text: 'Дуудлагын засвар'),
    const Tab(text: 'Машин ачилт'),
  ];

  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = ['images/Rectangle5275.png', 'images/Rectangle5275.png'];

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 8, activeDotColor: Color(0xFF404040), dotHeight: 8),
        activeIndex: activeIndex,
        count: urlImages.length,
      );
  void animateToSlide(int index) => controller.animateToPage(index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Дуудлагын засвар',
                            style: TextStyle(fontFamily: 'Inter'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                                backgroundColor:
                                    const Color.fromARGB(255, 243, 242, 242),
                                isScrollControlled: true,
                                context: context,
                                useSafeArea: true,
                                constraints: const BoxConstraints(
                                    maxHeight: double.infinity),
                                scrollControlDisabledMaxHeightRatio: 0.9,
                                builder: (BuildContext context) {
                                  return DefaultTabController(
                                    length: tabs.length,
                                    child: SafeArea(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 5,
                                            width: 63,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          TabBar(
                                            labelStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                            unselectedLabelColor:
                                                const Color(0xFF404040)
                                                    .withOpacity(0.5),
                                            labelColor: Colors.black,
                                            tabs: tabs,
                                            indicatorColor: Colors.black,
                                          ),
                                          const SWZasvar(),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color(0xff232323)),
                            child: SvgPicture.asset(
                              'images/headset_icon.svg',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
                                return const Swapping();
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
                            Cart(
                                img: SvgPicture.asset('images/Car_icon1.svg'),
                                txt: 'Агрегат'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon2.svg'),
                                txt: 'Кузов'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon3.svg'),
                                txt: 'Дугуй'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon4.svg'),
                                txt: 'Угаалга'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon5.svg'),
                                txt: 'Мотоцикл'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon6.svg'),
                                txt: 'Оношилгоо'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon7.svg'),
                                txt: 'Тос тосолгоо'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon8.svg'),
                                txt: 'Амартизатор'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon9.svg'),
                                txt: 'Акумлятор'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon10.svg'),
                                txt: 'Тэнхлэг тохиргоо'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon11.svg'),
                                txt: 'Мотор засвар'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon12.svg'),
                                txt: 'Явах эд анги'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon13.svg'),
                                txt: 'Эйр кондишн'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon14.svg'),
                                txt: 'Ком.оншилгоо'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon15.svg'),
                                txt: 'Сэлбэг худалдаа'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon16.svg'),
                                txt: 'Наклад тормос'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon17.svg'),
                                txt: 'Машин худалдаа'),
                            Cart(
                              img: SvgPicture.asset('images/Car_icon18.svg'),
                              txt: 'Машин будаг',
                            ),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon19.svg'),
                                txt: 'Дуудлагын засвар'),
                            Cart(
                                img: SvgPicture.asset('images/Car_icon20.svg'),
                                txt: 'Машин ачлага')
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
                                builder: (context) => const Place()),
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
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 530),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          // for (var item in _shops)
                          //   OfferPlace(
                          //     title: item['name'],
                          //     phone: item['phone'],
                          //     img: item['thumbnail'],
                          //   ),
                        ],
                      ),
                    ),
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
