import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Card.dart';
import 'package:final_pro/usable/Components/InsteadCategory.dart';

class Swapping extends StatefulWidget {
  Swapping({super.key});

  @override
  State<Swapping> createState() => _SwappingState();
}

class _SwappingState extends State<Swapping> {

  TextEditingController _cnt = TextEditingController();

  List<dynamic> _filteredShops = [];
  void _filterShops(String query) {
    query = query.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredShops = List.from(InsteadCategory.dataset);
      }
      else {
        _filteredShops = InsteadCategory.dataset.where((shop) {
          return shop['title'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void initState(){
    super.initState();
    _filteredShops = List.from(InsteadCategory.dataset);
  }
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
                              onChanged: _filterShops,
                              controller: _cnt,
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
                          height: 300,
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
                                   for(var item in _filteredShops)
                                     if(item['type'] == 'all')
                                       Cart2(img: item['img'], txt: item['title'])
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
                          height: 200,
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
                              for(var item in _filteredShops)
                                 if(item['type'] == 'service')
                                   Cart2(img: item['img'], txt: item['title'])
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
                          height: 100,
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
                              for(var item in _filteredShops)
                                if(item['type'] == 'call')
                                  Cart2(img: item['img'], txt: item['title'])
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
