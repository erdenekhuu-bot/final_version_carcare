import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:final_pro/pages/Home/Car/Car.dart';
class Zardal extends StatefulWidget {
  const Zardal({super.key});

  @override
  State<Zardal> createState() => _ZardalState();
}

class _ZardalState extends State<Zardal> {

  final TextEditingController _cnt1 = TextEditingController();
  final TextEditingController _cnt2 = TextEditingController();

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



  @override
  void initState(){
    super.initState();
    getService();
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

  final dropdownController = TextEditingController();
  final FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Зардлын мэдээлэл',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.white,centerTitle: true ,
    // leading: IconButton(
    //     icon: SvgPicture.asset(
    //       'images/iconBack.svg',
    //       width: 35,
    //       height: 35,
    //     ),
    //     onPressed: () {
    //       Navigator.pop(context);
    //     },
    //   ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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

                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      controller: _cnt2,
                      onChanged: (amount) {
                        setState(() {
                          setAmount = int.parse(_cnt2.text);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TableCalendar(
                      headerStyle: const HeaderStyle(
                          formatButtonVisible: false, titleCentered: true),
                      firstDay: DateTime.utc(2010, 3, 14),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      },
                    ),
                  ),
              const SizedBox(height: 20),
              SizedBox(
                width: 323,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      int result = await RESTAPI.createExpense(setServicePlace, setAmount, setServiceId, formatAPI(_selectedDay.toString()));
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
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
