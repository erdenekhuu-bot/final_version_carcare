import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:final_pro/pages/Home/HomePage/Home.dart';
import 'package:final_pro/usable/Components/MySelf.dart';
import 'package:final_pro/usable/Components/Uilchilgee.dart';
import 'package:final_pro/usable/Components/CustomDialog.dart';
import 'package:final_pro/usable/Components/DialogBoxQuit.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_pro/pages/Login/Login.dart';
class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  String _username = '';
  String _phone = '';
  @override
  void initState(){
    super.initState();
    getUser(Store.storePhone, Store.storePassword);
  }
  Future<void> getUser(String phone, String password) async {
    try {
      final Map<String, String> content = {
        "areaCode": "976",
        "phone": phone,
        "password": password
      };
      final request = await http.get(Uri.parse('https://dev-api.carcare.mn/v1/auth/identity'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
          }
      );
      if(request.statusCode == 200){
          setState(() {
             _username=json.decode(request.body)['data']['username'];
             _phone=json.decode(request.body)['data']['phone'];
          });
      }
    } catch(error){
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
        // leading: IconButton(
        //   icon: SvgPicture.asset('images/iconBack.svg', width: 35, height: 35),
        //   onPressed: () {
        //     pushScreen(context, screen: const Home(), withNavBar: false);
        //   },
        // ),
      ),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Container(
                            width: 90,
                            height: 80,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Colors.white),
                            child: SvgPicture.asset(
                              'images/icon.svg',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_username',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$_phone',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                child: Text(
                  'Үндсэн мэдээлэл',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Color(0xFF404040),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 50,
            child: GestureDetector(
              onTap: () {
                pushScreen(
                  context,
                  screen: MySelf(username: _username, phone: _phone),
                  withNavBar: false,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('images/iconSett.svg'),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('Хувийн мэдээлэл'),
                      ],
                    ),
                    const Opacity(
                      opacity: 0.5,
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: GestureDetector(
              onTap: () {
                pushScreen(
                  context,
                  screen: const Uilchilgee(),
                  withNavBar: false,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('images/iconMenu.svg'),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('Үйлчилгээний нөхцөл'),
                      ],
                    ),
                    const Opacity(
                      opacity: 0.5,
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 50,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomDialog();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('images/UserCall.svg'),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('Холбоо барих'),
                      ],
                    ),
                    const Opacity(
                      opacity: 0.5,
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 50,
            child: GestureDetector(
              onTap: () {
                quit(context);
              },

              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('images/UserExit.svg'),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('Гарах'),
                      ],
                    ),
                    const Opacity(
                      opacity: 0.5,
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


@override
void quit(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0,
          content: SizedBox(
            width: 308,
            height: 222,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.error,
                  size: 75,
                ),
                const Text(
                  'Та гарахдаа итгэлтэй байна уу?',
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 104,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF404040),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Үгүй',
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: Container(
                        width: 104,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF404040),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF404040)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Тийм',
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}