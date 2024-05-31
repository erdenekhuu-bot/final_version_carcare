import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OfferPlace extends StatelessWidget {
  final String? img;
  final String title;
  final String phone;
  OfferPlace({this.img, required this.title, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          (img != '')
              ? Padding(
                  padding: EdgeInsets.only(right: 8.0, left: 8),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network('$img'),
                    ),
                  ),
                )
              : Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$title', style: TextStyle(fontFamily: 'Inter')),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Даваа - Баасан', style: TextStyle(fontSize: 12)),
                      Text('09:00 - 18:00', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30, top: 5),
                        padding: EdgeInsets.only(left: 5, right: 9),
                        alignment: Alignment.center,
                        width: 116,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xffEDEDED),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset('images/phone.svg'),
                            Text('$phone'),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
