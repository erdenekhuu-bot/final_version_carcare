import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Prices extends StatelessWidget {
  final String? title;
  final double? price;
  final String? type;
  Prices({super.key, this.title, this.price, this.type});

  Widget? imageWidget;
  String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              height: 50, width: 50, child: imageWidget ?? SizedBox.shrink()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type!,
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Text('$title', style: const TextStyle(fontSize: 13)),
              Text(formattedDate, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
