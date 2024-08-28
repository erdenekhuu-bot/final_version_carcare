import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:final_pro/REST/AuthService.dart';
import 'package:final_pro/usable/Components/Helper.dart';

class MapPlaceWindow extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? img;
  final String? description;
  final int? id;
  const MapPlaceWindow({super.key, this.name, this.phone, this.img, this.description, this.id});

  @override
  State<MapPlaceWindow> createState() => _MapPlaceWindowState();
}

class _MapPlaceWindowState extends State<MapPlaceWindow> {

  bool limit=false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification){
              setState(() {
                double extendPercentage=notification.extent * 100;
                limit=extendPercentage >= screenWidth / 10;
              });
              return true;
            },
            child: DraggableScrollableSheet(
                initialChildSize: 0.3,
                maxChildSize: 1,
              builder: (BuildContext context, ScrollController scrollController){
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (Widget child, Animation<double> animation){
                      return FadeTransition(opacity: animation, child: child);
                    },
                  child: limit ?
                        SecondWindow(
                            scrollController: scrollController,
                            name: widget.name,
                            img: widget.img,
                            description: widget.description,
                            phone: widget.phone,
                            id: widget.id
                        ) :
                        FirstWindow(
                          scrollController: scrollController,
                          name: widget.name,
                          img: widget.img,
                          description: widget.description,
                          phone: widget.phone,
                          id: widget.id
                        )
                );
              }
            ),
          ),
        )
      ],
    );
  }
}


class FirstWindow extends StatefulWidget {
  final ScrollController scrollController;
  final String? name;
  final String? phone;
  final String? img;
  final String? description;
  final int? id;
  FirstWindow({super.key, required this.scrollController, this.name, this.phone, this.img, this.description, this.id});

  @override
  State<FirstWindow> createState() => _FirstWindowState();
}

class _FirstWindowState extends State<FirstWindow> {

    List<dynamic> customShops = [];
    String startTime ='';
    String endTime='';
    String holiday_startTime='';
    String holiday_endTime = '';

    void getShop() async {
      String? access=await Helper.readDefaultToken();
      String? refresh=await Helper.readToken();
      AuthService authService = AuthService(access!, refresh!);
      List<dynamic> result = await authService.eachPlaces(widget.id!);
      setState(() {
          customShops=result;
      });
    }

    @override
    void initState(){
      getShop();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
     for (var item in customShops) {
          if(item['shop_schedules'] is List<dynamic> && item['shop_schedules'] != null){
             for(int i=0; i<item['shop_schedules'].length; i++){
                if(i<1){
                  setState(() {
                    startTime=item['shop_schedules'][i]['start_time'].substring(11,16);
                    endTime=item['shop_schedules'][i]['end_time'].substring(11,16);
                  });
                }
                if(item['shop_schedules'][i]['week_day'] == 6){
                  setState(() {
                    holiday_startTime=item['shop_schedules'][i]['start_time'].substring(11,16);
                    holiday_endTime=item['shop_schedules'][i]['end_time'].substring(11,16);
                  });
                }
             }
          }
        }
     return CustomScrollView(
       controller: widget.scrollController,
       slivers: [
         SliverList.list(children: [
             Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20.0),
                 ), 
                 ),
             Container(
               width: double.infinity,
               height: screenHeight / 2.5,
               color: Colors.white,
               padding: EdgeInsets.symmetric(vertical: 1),
               child: Column(
                 children: [
                  Container( 
                    margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: Colors.grey
                    ),
                  width: 70,
                  height: 5,
                 ),
                 SizedBox(height: 10),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                           width: screenWidth * 0.5,
                           height: screenWidth * 0.5,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               boxShadow: [
                                 BoxShadow(color: Colors.black.withOpacity(0.4))
                               ]
                           ),
                           child: AspectRatio(
                               aspectRatio: 1,
                               child: Image.network('https://d3v7ghkqvtko5q.cloudfront.net/${widget.img}', fit: BoxFit.cover),
                           ),
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             margin: null,
                             width: screenWidth * 0.4,
                             padding: const EdgeInsets.symmetric(vertical: 8),
                             child: Text('${widget.name}', style: TextStyle(fontFamily: 'Inter-SemiBold', fontSize: screenWidth / 19)),
                           ),
                           GestureDetector(
                             onTap: () async {
                               Uri uri = Uri.parse('tel:${widget.phone!}');
                               try {
                                 if(await canLaunchUrl(uri)){
                                   await launchUrl(uri);
                                 }
                               } catch(error) {
                                 return;
                               }
                             },
                             child: Container(
                               margin: null,
                               width: screenWidth * 0.4,
                               height: 38,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFF404040)),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   SvgPicture.asset('images/phone.svg', color: Colors.white, width: 15, height: 15),
                                   Text('${Store.convertPhone(Store.Divide(widget.phone!))}', style: TextStyle(color: Colors.white, fontFamily: 'Inter-Regular', fontSize: 17))
                                 ],
                               ),
                             ),
                           ),
                           const SizedBox(height: 8),
                           Text('Даваа - Баасан', style: TextStyle(color: Color(0xFF404040), fontSize: screenWidth / 25, fontFamily: 'Inter-Regular')),
                           Text('$startTime - ${endTime}', style: TextStyle(color: Color(0xff404040), fontSize: screenWidth / 28, fontFamily: 'Inter-Regular')),
                           Text('Бямба - Ням', style: TextStyle(color: Color(0xFF404040), fontSize: screenWidth / 25, fontFamily: 'Inter-Regular')),
                           Text('${holiday_startTime} - ${holiday_endTime}', style: TextStyle(color: Color(0xff404040), fontSize: screenWidth / 28, fontFamily: 'Inter-Regular'))
                         ],
                       ),

                     ],
                   )
                 ],
               ),
             )
         ])
       ],
     );
  }
}

class SecondWindow extends StatefulWidget {
    final ScrollController scrollController;
    final String? name;
    final String? phone;
    final String? img;
    final String? description;
    final int? id;
    SecondWindow({super.key, required this.scrollController, this.name, this.phone, this.img, this.description,this.id});


  @override
  State<SecondWindow> createState() => _SecondWindowState();
}

class _SecondWindowState extends State<SecondWindow> {

  List<dynamic> customShops = [];
    String startTime ='';
    String endTime='';
    String holiday_startTime='';
    String holiday_endTime = '';
    List<dynamic> shopServices=[];
    String address='';

    void getShop() async {
      String? access=await Helper.readDefaultToken();
      String? refresh=await Helper.readToken();
      AuthService authService = AuthService(access!, refresh!);
      List<dynamic> result = await authService.eachPlaces(widget.id!);
      setState(() {
          customShops=result;
      });
    }

    @override
    void initState(){
      super.initState();
      getShop();
    }

  @override
    Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    for (var item in customShops) {
      setState(() {
        address=item['shop_location']['address'];
      });
      if(item['shop_schedules'] is List<dynamic> && item['shop_schedules'] != null){
        for(int i=0; i<item['shop_schedules'].length; i++){
          if(i<1){
            setState(() {
              startTime=item['shop_schedules'][i]['start_time'].substring(11,16);
              endTime=item['shop_schedules'][i]['end_time'].substring(11,16);
            });
          }
          if(item['shop_schedules'][i]['week_day'] == 6){
            setState(() {
              holiday_startTime=item['shop_schedules'][i]['start_time'].substring(11,16);
              holiday_endTime=item['shop_schedules'][i]['end_time'].substring(11,16);
            });
          }
        }
      }
    }
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: [
        SliverList.list(children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            height: screenHeight*1.2,
            padding: EdgeInsets.all(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container( 
                    margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: Colors.grey
                    ),
                  width: 70,
                  height: 5,
                 ),
                 SizedBox(height: 8),
                Container(
                  height: screenHeight / 2.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      'https://d3v7ghkqvtko5q.cloudfront.net/${widget.img!}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenWidth / 12),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 0.1)),
                      child: ClipOval(
                        child: Image.network(
                          'https://d3v7ghkqvtko5q.cloudfront.net/${widget.img!}',
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.5,
                            padding: EdgeInsets.symmetric(horizontal: screenWidth / 70),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text('${widget.name}', style: TextStyle(fontFamily: 'Inter-SemiBold', fontSize: 22)),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Uri uri = Uri.parse('tel:${widget.phone!}');
                              try {
                                if(await canLaunchUrl(uri)){
                                  await launchUrl(uri);
                                }
                              } catch(error) {
                                return;
                              }
                            },
                            child: Container(
                              width: screenWidth * 0.4,
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                color: const Color(0xFF404040),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'images/phone.svg',
                                    color: Colors.white,
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text('${Store.convertPhone(Store.Divide(widget.phone!))}', style: TextStyle(color: Colors.white, fontFamily: 'Inter-Regular', fontSize: 17))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, bottom: 8, top: 10),
                      child: Text('Үйлчилгээ', style: TextStyle(fontFamily: 'Inter-Medium', fontSize: 20, color: Color(0xff404040), fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenHeight / 2.8,
                        child: Text('${widget.description}', style: TextStyle(color: Color(0xFF404040), fontSize: 15, fontFamily: 'Inter-Regular')),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Байршил', style:  TextStyle(fontFamily: 'Inter-Medium', fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenHeight / 2.8,
                                child: Text('$address', style: TextStyle(color: Color(0xFF404040), fontFamily: 'Inter-Regular', fontSize: 15)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Цагийн хуваарь', style: TextStyle(fontFamily: 'Inter-Medium', fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text('Даваа - Баасан  $startTime - ${endTime}', style: TextStyle(color: Color(0xFF404040), fontFamily: 'Inter-Regular', fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Бямба - Ням ${holiday_startTime} - ${holiday_endTime}', style: TextStyle(color: Color(0xFF404040), fontFamily: 'Inter-Regular', fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenHeight / 2.8,
                            child: Text('Toyota бүх төрлийн авто машин', style: TextStyle(fontFamily: 'Inter-Medium', fontSize: 18, fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ])
      ],
    );
  }
}