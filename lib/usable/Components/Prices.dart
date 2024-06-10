import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Prices extends StatelessWidget {
  final String? title;
  final double? price;
  final String? type;
  Prices({super.key, this.title, this.price, this.type});

  Widget? imageWidget;
  String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {

    switch (type) {
      case 'Моторын Тос':
        imageWidget = SvgPicture.asset('images/Car_icon7.svg');
        break;
      case 'Агрегат':
        imageWidget = SvgPicture.asset('images/Car_icon1.svg');
        break;
      case 'Агааржуулалт':
        imageWidget = SvgPicture.asset('images/Car_icon13.svg');
      case 'Оношилгоо':
        imageWidget = SvgPicture.asset('images/Car_icon6.svg');
      case 'Аккумлятор':
        imageWidget = SvgPicture.asset('images/Car_icon9.svg');
      case 'Амартизатор':
        imageWidget = SvgPicture.asset('images/Car_icon8.svg');
      case 'Компьютер оншилгоо':
        imageWidget = SvgPicture.asset('images/Car_icon14.svg');
      case 'Мотор':
        imageWidget = SvgPicture.asset('images/Car_icon11.svg');
      case 'Дугуй':
        imageWidget = SvgPicture.asset('images/Car_icon3.svg');
      case 'Тэнхлэг ':
        imageWidget = SvgPicture.asset('images/Car_icon10.svg');
      case 'Наклад':
        imageWidget = SvgPicture.asset('images/Car_icon16.svg');
        break;
      default:
        imageWidget = const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  child: imageWidget ?? const SizedBox.shrink()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type!,
                      style: const TextStyle(
                          fontFamily: 'Inter-Bold',
                          fontSize: 15)),
                  Text('$title', style: const TextStyle(fontSize: 13)),
                  Text(formattedDate, style: const TextStyle(fontSize: 12)),
                ],
              ),
              Container(
                padding: null,
                child: Text('${price!.toInt()}₮', style: const TextStyle(fontFamily: 'Inter-Bold', fontSize: 15)),
              ),
            ],
      ),
    );
  }
}
