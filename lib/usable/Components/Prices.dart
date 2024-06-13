import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Prices extends StatelessWidget {
  final String? title;
  final double? price;
  final String? type;
  final String? imageWidget;
  Prices({super.key, this.title, this.price, this.type, this.imageWidget});


  String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  child: Image.network(imageWidget!) ?? const SizedBox.shrink()),
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
