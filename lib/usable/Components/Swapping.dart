import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Card.dart';

class Swapping extends StatelessWidget {
  const Swapping({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
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
            maxChildSize: 0.99,
            initialChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 242, 242),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
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
                                    color: const Color(0xFF404040)
                                        .withOpacity(0.5),
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
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(right: 15, left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Wrap(
                            spacing: 6.0,
                            runSpacing: 5.0,
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Cart2(
                                  img: SvgPicture.asset('images/Car_icon6.svg'),
                                  txt: 'Оношилгоо'),
                              Cart2(
                                  img: SvgPicture.asset('images/Car_icon7.svg'),
                                  txt: 'Тос тосолгоо'),
                              Cart2(
                                  img: SvgPicture.asset('images/Car_icon8.svg'),
                                  txt: 'Амартизатор'),
                              Cart2(
                                  img: SvgPicture.asset('images/Car_icon9.svg'),
                                  txt: 'Аккумлятор'),
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon10.svg'),
                                  txt: 'Тэнхлэг тохиргоо'),
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon11.svg'),
                                  txt: 'Мотор засвар'),
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon12.svg'),
                                  txt: 'Явах эд анги'),
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon13.svg'),
                                  txt: 'Эйр кондишн'),
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon14.svg'),
                                  txt: 'Ком. оношилгоо'),
                              Cart2(
                                  img: SvgPicture.asset('images/Car_icon3.svg'),
                                  txt: 'Дугуй'),
                              Cart2(
                                  img: SvgPicture.asset('images/Car_icon2.svg'),
                                  txt: 'Кузов'),
                              Cart2(
                                  img: SvgPicture.asset(
                                      'images/Наклад_тормос.svg'),
                                  txt: 'Наклад тормос'),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 40, top: 10, bottom: 10),
                              child: Text(
                                'Авто үйлчилгээ',
                                style: TextStyle(
                                    fontFamily: 'Inter', fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(right: 15, left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Wrap(
                            spacing: 6.0,
                            runSpacing: 5.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Cart2(
                                  img: SvgPicture.asset('images/Car_icon4.svg'),
                                  txt: 'Угаалга'),
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon15.svg'),
                                  txt: 'Сэлбэг худалдаа'),
                              Cart2(
                                  img: SvgPicture.asset('images/Car_icon5.svg'),
                                  txt: 'Мотоцикл'),
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon17.svg'),
                                  txt: 'Машин худалдаа'),
                              Cart2(
                                img: SvgPicture.asset('images/Car_icon18.svg'),
                                txt: 'Машин будаг',
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 40, top: 10, bottom: 10),
                              child: Text(
                                'Дуудлагын үйлчилгээ',
                                style: TextStyle(
                                    fontFamily: 'Inter', fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              right: 15, left: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Wrap(
                            spacing: 6.0,
                            runSpacing: 5.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon19.svg'),
                                  txt: 'Дуудлагын засвар'),
                              Cart2(
                                  img:
                                      SvgPicture.asset('images/Car_icon20.svg'),
                                  txt: 'Машин ачлага')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
