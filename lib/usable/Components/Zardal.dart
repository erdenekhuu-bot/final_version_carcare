import 'package:flutter/material.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:final_pro/pages/Home/Car/Car.dart';
import 'package:final_pro/usable/Components/Swapping.dart';

class Zardal extends StatefulWidget {
  const Zardal({super.key});

  @override
  State<Zardal> createState() => _ZardalState();
}

class _ZardalState extends State<Zardal> {

  final TextEditingController _cnt1 = TextEditingController();
  final TextEditingController _cnt2 = TextEditingController();
  final ScrollController _scr = ScrollController();

  final FocusNode _fn1 = FocusNode();

  DateTime _selectedDay = DateTime.now();

  String formatAPI(String rightFormat) {
    return rightFormat.substring(0, 19);
  }
  int setServiceId = 0;
  String? selectedValue;
  List<dynamic> data = [];
  String setServicePlace = '';

  int setAmount=0;
  final _formKey = GlobalKey<FormState>();

  void findId(List<dynamic> data, String service) {
    for (var index in data) {
      if (index['name'] == service) {
        setState(() {
          setServiceId = index['id'];
        });
      }
    }
  }

  final ScrollController _scrollController = ScrollController();
  bool isScrolledToBottom = true;


  @override
  void initState(){
    getService();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    focus.dispose();
    _fn1.dispose();
    _cnt1.dispose();
    _cnt2.dispose();
  }
  void getService() async {
    List<dynamic> result = await RESTAPI.getServices();
    setState(() {
      data=result;
    });
  }

  bool _isDayEnabled(DateTime day) {
    return day.isBefore(DateTime.now());
  }


  final dropdownController = TextEditingController();
  final FocusNode focus = FocusNode();



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Зардлын мэдээлэл',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.white,centerTitle: true ,
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Text(
                        'Үйлчилгээ',
                        style: TextStyle(fontSize: 16, fontFamily: 'Inter-Light'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth / 80),
                Container(
                  width: screenWidth * 0.85,
                  height: screenWidth / 10,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      underline: null,
                      dropdownColor: const Color(0xffffffff),
                      focusColor: Colors.black12,
                      focusNode: focus,
                      value: selectedValue,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                        findId(data, selectedValue.toString());
                      },
                      items: data.map((e) {
                        return DropdownMenuItem<String>(
                          value: e['name'],
                          child: Text(e['name']),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(height: screenWidth / 80),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Text(
                        'Үйлчилгээ авсан газар',
                        style: TextStyle(fontSize: 16, fontFamily: 'Inter-Light'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth / 80),
                SizedBox(
                  width: screenWidth * 0.85,
                  height: screenWidth / 10,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,
                    controller: _cnt1,
                    focusNode: _fn1,
                    onChanged: (place) {
                      setState(() {
                        setServicePlace = _cnt1.text;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(width: 1,color: Color(0xff404040))),
                    ),
                  ),
                ),
                SizedBox(height: screenWidth / 80),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Үнэ',
                        style: TextStyle(fontSize: 16, fontFamily: 'Inter-Light'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth / 80),
                SizedBox(
                  width: screenWidth * 0.85,
                  height: screenWidth / 10,
                  child: TextFormField(
                    maxLength: 9,
                    textAlignVertical: TextAlignVertical.top,
                    controller: _cnt2,
                    onChanged: (amount) {
                      setState(() {
                        setAmount = int.parse(_cnt2.text);
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: const TextStyle(fontFamily: 'Inter-Light'),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(width: 1,color: Color(0xff404040))),
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  setState(() {
                    isScrolledToBottom=!isScrolledToBottom;
                  });
                }, icon: const Icon(Icons.calendar_month)),
                Opacity(
                  opacity: isScrolledToBottom ? 0.3 : 1,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.85),
                    child: AbsorbPointer(
                      absorbing: isScrolledToBottom,
                      child: TableCalendar(
                        weekNumbersVisible: false,
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true
                        ),
                        firstDay: DateTime.utc(2010, 3, 14),
                        lastDay: DateTime.utc(2130, 3, 14),
                        focusedDay: _selectedDay,
                        pageAnimationEnabled: false,
                        pageJumpingEnabled: false,
                        daysOfWeekVisible: false,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        enabledDayPredicate: _isDayEnabled,
                        calendarStyle: const CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: Color(0xff404040),
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(color: Colors.white),
                          todayTextStyle: TextStyle(color: Colors.white),
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            focusedDay = selectedDay;
                          });
                        },
                      ),

                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: screenWidth * 0.85,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      int result = await RESTAPI.createExpense(setServicePlace, setAmount, setServiceId, formatAPI(_selectedDay.toString()).substring(0,10));
                      if(result > 0){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Car()));
                      } else {
                        print('Something not right');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff404040),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Хадгалах',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


