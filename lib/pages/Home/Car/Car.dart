import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/usable/Components/Zardal.dart';
import 'package:final_pro/usable/Components/Prices.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'dart:math';
import 'dart:convert';
import 'package:final_pro/REST/RESTAPI.dart';

class Car extends StatefulWidget {
  const Car({super.key});
  @override
  State<Car> createState() => _CarState();
}

class _CarState extends State<Car> {
  Random random = Random();
  int price = 0;
  bool _click = false;
  bool switchArrow = false;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  List<dynamic> data = [];
  List<dynamic> service = [];
  var formatter = NumberFormat('#,###', 'en_US');

  @override
  void initState() {
    getExpense();
    super.initState();
  }

  Future<void> getExpense() async {
    try {
      final request = await RESTAPI.client.get(
          Uri.parse('https://admin-dev.carcare.mn/api/expenses/'),
          headers: {'Authorization': 'Bearer ${Store.accessToken}'});
      if (request.statusCode == 200) {
        setState(() {
          data = json.decode(utf8.decode(request.bodyBytes))['results'];
          service = Store.filterServices;
        });
      }
    } catch (error) {
      return;
    }
  }

  String switchServiceToName(int id) {
    for (var item in service) if (item['id'] == id) return item['name'];
    return '';
  }

  String switchServiceToAsset(int id) {
    for (var item in service) if (item['id'] == id) return item['asset_path'];
    return '';
  }

  void refresh() {
    getExpense();
  }

  String convertHumanReadMoney(int money) {
    return formatter.format(money);
  }

  int filterMonth(String argument) {
    return int.parse(argument.substring(5, 7));
  }

  int filterYear(String argument) {
    return int.parse(argument.substring(0, 4));
  }

  double totalAmount = 0.0;
  bool shouldContinue = true;
  int touchedIndex = 0;
  PieTouchResponse? pieTouchResponse;
  String? touchedSectionTitle;
  String zardal = 'Зардлын график';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    totalAmount = 0.0;
    for (var item in data) {
      totalAmount += item['amount'];
      Store.amount = totalAmount;
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                    width: screenWidth * 0.45,
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
                      child: Text('Сар',
                          style: TextStyle(
                              fontSize: 16,
                              color: _click ? Colors.black : Colors.white)),
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
                    width: screenWidth * 0.45,
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
                          backgroundColor:
                              _click ? const Color(0xff404040) : Colors.white),
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
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold))
                        : Text('${month} сар',
                            style: const TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (data.isEmpty)
                    const Text('Нийт зардал 0₮',
                        style:
                            TextStyle(fontFamily: 'Inter-Bold', fontSize: 20))
                  else
                    Text(
                        'Нийт зардал ${convertHumanReadMoney(Store.amount.toInt())}₮',
                        style: const TextStyle(
                            fontFamily: 'Inter-Bold', fontSize: 20))
                ],
              ),
              SizedBox(height: screenWidth / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: null,
                    width: 230,
                    height: 230,
                    child: Stack(
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    touchedSectionTitle = null;
                                  } else {
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                    touchedSectionTitle = switchServiceToName(
                                        data[touchedIndex]['service']);
                                    if (_click == false &&
                                            filterMonth(data[touchedIndex]
                                                    ['service_date']) ==
                                                month ||
                                        _click == true &&
                                            filterYear(data[touchedIndex]
                                                    ['service_date']) ==
                                                year) {
                                      setState(() {
                                        zardal = touchedSectionTitle!;
                                      });
                                    } else {
                                      setState(() {
                                        zardal = 'Зардлын график';
                                      });
                                    }
                                  }
                                });
                              },
                            ),
                            startDegreeOffset: 820,
                            centerSpaceRadius: 70 % screenWidth,
                            sections: data.isNotEmpty
                                ? [
                                    for (var item in data)
                                      if (_click == false &&
                                              filterMonth(
                                                      item['service_date']) ==
                                                  month ||
                                          _click == true &&
                                              filterYear(
                                                      item['service_date']) ==
                                                  year)
                                        PieChartSectionData(
                                            value: _click
                                                ? item['amount'].toDouble() +
                                                    totalAmount / 365
                                                : item['amount'].toDouble() +
                                                    totalAmount / 30,
                                            title: '',
                                            badgeWidget: null,
                                            //color: Color.fromARGB(150, random.nextInt(256), random.nextInt(256), random.nextInt(256)),
                                            color: Color(Store.colorsRange(
                                                switchServiceToName(
                                                    item['service']))),
                                            badgePositionPercentageOffset: 1.5)
                                      else
                                        PieChartSectionData(
                                            value: 100,
                                            title: '',
                                            color: const Color(0xFFD787FF),
                                            badgeWidget: null,
                                            badgePositionPercentageOffset: 1.5)
                                  ]
                                : [
                                    PieChartSectionData(
                                        value: 100,
                                        color: const Color(0xFFD787FF),
                                        badgeWidget: null,
                                        title: '',
                                        badgePositionPercentageOffset: 1.5),
                                  ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (data.isEmpty)
                              const Center(
                                child: Text('Зардлын график',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            else
                              Center(
                                child: Text('${zardal}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Column(
                children: data.length > 0
                    ? [
                        for (var item in data)
                          if (_click == false &&
                                  filterMonth(item['service_date']) == month ||
                              _click == true &&
                                  filterYear(item['service_date']) == year)
                            _click
                                ? Prices(
                                    title: item['service_place'],
                                    price: item['amount'].toDouble(),
                                    type: switchServiceToName(item['service']),
                                    imageWidget:
                                        switchServiceToAsset(item['service']),
                                    dateDay: item['service_date'],
                                    id: item['id'],
                                    onRefresh: refresh)
                                : Prices(
                                    title: item['service_place'],
                                    price: item['amount'].toDouble(),
                                    type: switchServiceToName(item['service']),
                                    imageWidget:
                                        switchServiceToAsset(item['service']),
                                    dateDay: item['service_date'],
                                    id: item['id'],
                                    onRefresh: refresh)
                      ]
                    : [
                        Center(
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
                      ],
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Zardal()));
        },
        backgroundColor: const Color(0xff404040),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
