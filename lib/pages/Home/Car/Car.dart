import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../usable/Components/CustomChart.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Car extends StatefulWidget {
  const Car({super.key});

  @override
  State<Car> createState() => _CarState();
}

class _CarState extends State<Car> {
  int price = 0;
  bool _click = true;
  double totalAmount = 0.0;
  bool switchArrow = false;

  int month = DateTime.now().month;
  int year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Зарлага',
                        style: TextStyle(
                            fontFamily: 'Inter-ExtraBold', fontSize: 20))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 170,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_click == true) {
                              _click = !_click;
                            } else {
                              _click = _click;
                            }
                          });
                        },
                        child: Text(
                          'Сар',
                          style: TextStyle(
                              fontSize: 16,
                              color: _click ? Colors.black : Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.black, width: 1)),
                          backgroundColor:
                              Color(_click ? 0xffffffff : 0xff404040),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 170,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_click == false) {
                              _click = !_click;
                            } else {
                              _click = _click;
                            }
                          });
                        },
                        child: Text('Жил',
                            style: TextStyle(
                                color: _click ? Colors.white : Colors.black,
                                fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.black, width: 1)),
                            backgroundColor: _click
                                ? const Color(0xff404040)
                                : Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: const Icon(Icons.arrow_back_ios_new_outlined),
                          onTap: () {
                            setState(() {
                              month -= 1;
                              year -= 1;
                              if (month < 1) {
                                month = 12;
                              }
                            });
                          }),
                      _click
                          ? Text('${year} он',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))
                          : Text('${month} сар',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                      GestureDetector(
                          child: const Icon(Icons.arrow_forward_ios_outlined),
                          onTap: () {
                            setState(() {
                              month += 1;
                              year += 1;
                              if (month > 12) {
                                month = 1;
                              }
                            });
                          })
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Нийт зардал 0₮',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 230,
                      height: 230,
                      child: const Stack(
                        children: [
                          CustomChart(),
                          Center(
                            child: Text(
                              'Зардлын график',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 265),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.vertical,
                    // child: Column(
                    //   children: data.length > 0
                    //       ? [
                    //           for (var item in data)
                    //             Prices(
                    //               title: item['servicePlace'],
                    //               price: item['amount'].toDouble(),
                    //               type: item['service']['name'],
                    //             )
                    //         ]
                    //       : [
                    //           Center(
                    //             child: Column(
                    //               children: [
                    //                 SvgPicture.asset(
                    //                     'images/streamline_desktop-delete.svg'),
                    //                 SizedBox(height: 10),
                    //                 Text(
                    //                   'Үр дүн олдсонгүй',
                    //                   style: TextStyle(fontSize: 16),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    // ),
                    child: Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                              'images/streamline_desktop-delete.svg'),
                          const SizedBox(height: 10),
                          const Text(
                            'Үр дүн олдсонгүй',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
