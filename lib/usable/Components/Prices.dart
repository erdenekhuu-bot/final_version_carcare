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
      case 'Тос тосолгоо':
        imageWidget = SvgPicture.asset('images/Car_icon7.svg');
        break;
      case 'Кузов':
        imageWidget = SvgPicture.asset('images/Car_icon2.svg');
        break;
      case 'Мотоцикл':
        imageWidget = SvgPicture.asset('images/Car_icon5.svg');
        break;
      case 'Угаалга':
        imageWidget = SvgPicture.asset('images/Car_icon4.svg');
        break;
      case 'Суудлын бүрээс':
        imageWidget = SvgPicture.asset('images/Car_icon12.svg');
        break;
      case 'Машин худалдаа':
        imageWidget = SvgPicture.asset('images/Car_icon17.svg');
        break;
      case 'Сэлбэг худалдаа':
        imageWidget = SvgPicture.asset('images/Car_icon15.svg');
        break;
      case 'Машин будаг':
        imageWidget = SvgPicture.asset('images/Car_icon18.svg');
        break;
      case 'Дугуй':
        imageWidget = SvgPicture.asset('images/Car_icon3.svg');
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
