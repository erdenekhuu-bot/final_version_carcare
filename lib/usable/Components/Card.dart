import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Cart extends StatelessWidget {
  // final Widget img;
  final String txt;
  final String img;
  const Cart({super.key, required this.img, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xff404040),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Image.network(img),
        ),
        Text(txt, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

class Cart2 extends StatelessWidget {
  final String img;
  final String txt;

  const Cart2({super.key, required this.img, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 3, right: 3, top: 8),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 7, left: 7),
            alignment: Alignment.center,
            width: 63,
            height: 63,
            decoration: BoxDecoration(
              color: const Color(0xff404040),
              borderRadius: BorderRadius.circular(70),
            ),
            child: SvgPicture.asset(img),
          ),
          Text(txt, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
