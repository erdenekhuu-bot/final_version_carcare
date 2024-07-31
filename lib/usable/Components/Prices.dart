import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/REST/RESTAPI.dart';

class Prices extends StatefulWidget {
    final String? title;
    final double? price;
    final String? type;
    final String? imageWidget;
    final String? dateDay;
    final int? id;
    final int? serviceId;
    final VoidCallback? onRefresh;
    Prices({super.key, this.title, this.price, this.type, this.imageWidget, this.dateDay, this.id, this.onRefresh, this.serviceId});

  @override
  State<Prices> createState() => _PricesState();
}

class _PricesState extends State<Prices> {

  final format = NumberFormat("#,##0", "en_US");

  String filterHumanReadable(String currentDate){
    return currentDate.substring(0,10).replaceAll('-', '/');
  }

  String convertHumanReadMoney(int money){
    return format.format(money);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (value) async {
          if(value.name == 'endToStart'){
              int response = await RESTAPI.deleteExpense(widget.id!);
              if(response > 0){
                 widget.onRefresh!();
              }
          }
        },
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text("Түр хүлээнэ үү.", style: TextStyle(fontSize: 15, fontFamily: 'Inter-Bold')),
                content: const Text("Зарлагын мэдээллээ устгах уу?", style: TextStyle(fontFamily: 'Inter-Regular', fontSize: 15)),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Үгүй", style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Тийм", style: TextStyle(color: Colors.black)),
                  ),
                ],
              );
            },
          );
        }
        return false;
      },
        key: UniqueKey(),
        child: Container(
        padding: null,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xffE2E2E2)))),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.symmetric(horizontal: screenWidth / 18),
                        child: SvgPicture.network('https://d3v7ghkqvtko5q.cloudfront.net/${widget.imageWidget!}')
                    ),
                    Container(
                      margin: null,
                      width: screenWidth * 0.42,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.type}', style: const TextStyle(fontFamily: 'Inter-Medium', fontWeight: FontWeight.bold, fontSize: 17)),
                          Text('${widget.title}', style: const TextStyle(fontSize: 14, fontFamily: 'Inter-Regular', color: Color(0xff666666))),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('${filterHumanReadable(widget.dateDay!)}', style: const TextStyle(fontSize: 15, fontFamily: 'Inter-Regular', color: Color(0xff666666))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: null,
                  child: Text('${convertHumanReadMoney(widget.price!.toInt())} ₮', style: const TextStyle(fontFamily: 'Inter-Medium', fontSize: 18)),
                ),
              ],
            ),
          ],
        )
    ),
    );

  }
}
