import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapPlaceWindow extends StatelessWidget {
  final String? name;
  final String? phone;
  final String? img;
  final String? description;
  final String? address;

  MapPlaceWindow(
      {this.name, this.phone, this.img, this.description, this.address});
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 1,
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            clipBehavior: Clip.hardEdge,
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: DraggableScrollableSheet(
                  maxChildSize: 1,
                  initialChildSize: 0.4,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 242, 242),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 5,
                                width: 63,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 331,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  '$img',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xFF404040),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$name',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 19),
                                        ),
                                        Container(
                                          width: 148,
                                          height: 38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: Color(0xFF404040),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SvgPicture.asset(
                                                'images/phone.svg',
                                                color: Colors.white,
                                                width: 15,
                                                height: 15,
                                              ),
                                              Text(
                                                '$phone',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 10, top: 10),
                                    child: Text(
                                      'Үйлчилгээ',
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 18,
                                  children: [
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon1.svg'),
                                    //     txt: 'Агрегат'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon2.svg'),
                                    //     txt: 'Кузов'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon3.svg'),
                                    //     txt: 'Дугуй'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon4.svg'),
                                    //     txt: 'Угаалга'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon5.svg'),
                                    //     txt:
                                    //     'Мотоцикл'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon6.svg'),
                                    //     txt:
                                    //     'Оношилгоо'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon7.svg'),
                                    //     txt:
                                    //     'Тос тосолгоо'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon8.svg'),
                                    //     txt:
                                    //     'Амартизатор'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon9.svg'),
                                    //     txt:
                                    //     'Акумлятор'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon10.svg'),
                                    //     txt:
                                    //     'Тэнхлэг тохиргоо'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon11.svg'),
                                    //     txt:
                                    //     'Мотор засвар'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon12.svg'),
                                    //     txt:
                                    //     'Явах эд анги'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon13.svg'),
                                    //     txt:
                                    //     'Эйр кондишн'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon14.svg'),
                                    //     txt:
                                    //     'Ком.оншилгоо'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon15.svg'),
                                    //     txt:
                                    //     'Сэлбэг худалдаа'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon16.svg'),
                                    //     txt:
                                    //     'Наклад тормос'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon17.svg'),
                                    //     txt:
                                    //     'Машин худалдаа'),
                                    // Cart(
                                    //   img: SvgPicture.asset(
                                    //       'images/Car_icon18.svg'),
                                    //   txt:
                                    //   'Машин будаг',
                                    // ),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon19.svg'),
                                    //     txt:
                                    //     'Дуудлагын засвар'),
                                    // Cart(
                                    //     img: SvgPicture
                                    //         .asset(
                                    //         'images/Car_icon20.svg'),
                                    //     txt:
                                    //     'Машин ачлага')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 30.0, left: 30, top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$description',
                                      style:
                                      TextStyle(color: Color(0xFF404040)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Байршил',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '$address',
                                              style: TextStyle(
                                                  color: Color(0xFF404040)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Цагийн хуваарь',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Даваа-Баасан 09:00 - 18:00',
                                              style: TextStyle(
                                                  color: Color(0xFF404040)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Бямба 10:00 - 15:00',
                                              style: TextStyle(
                                                  color: Color(0xFF404040)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text('Toyota бүх төрлийн авто машин',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 16))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))));
  }
}
