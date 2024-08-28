import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:final_pro/usable/Components/MySelf.dart';
import 'package:final_pro/usable/Components/Uilchilgee.dart';
import 'package:final_pro/usable/Components/CustomDialog.dart';
import 'package:final_pro/pages/Login/Login.dart';
import 'package:final_pro/usable/Components/Helper.dart';
import 'package:final_pro/REST/AuthService.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  String _username = '';
  String _phone = '';


  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    try {
      String? access=await Helper.readDefaultToken();
      String? refresh=await Helper.readToken();
      String? phone=await Helper.readPhone();
      AuthService authService = AuthService(access!, refresh!);
      List<dynamic> results = await authService.getUser();
        for (var item in results) {
          if (item['phonenumber'].substring(4) == phone) {
            await Helper.username(item['username']);
            setState(() {
              _username = item['username'];
              _phone = item['phonenumber'].substring(4);
            });
            break;
          }
        }

    } catch (error) {
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  height: screenWidth * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
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
                                      borderRadius: BorderRadius.all(Radius.circular(40)),
                                      color: Colors.white),
                                  child: SvgPicture.asset(
                                    'images/icon.svg',
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('$_username', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text('$_phone'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenWidth / 35, left: 20, bottom: screenWidth / 35),
                      child: const Text('Үндсэн мэдээлэл', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Color(0xFF404040))),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MySelf(username: _username, phone: _phone))).then((_){
                      getUser();
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('images/iconSett.svg'),
                              const SizedBox(width: 20),
                              const Text('Хувийн мэдээлэл'),
                            ],
                          ),
                          const Opacity(opacity: 0.5, child: Icon(Icons.arrow_forward_ios_rounded))
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pushScreen(context, screen: const Uilchilgee(), withNavBar: false);
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('images/iconMenu.svg'),
                              const SizedBox(width: 20),
                              const Text('Үйлчилгээний нөхцөл'),
                            ],
                          ),
                          const Opacity(opacity: 0.5, child: Icon(Icons.arrow_forward_ios_rounded))
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog();
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('images/UserCall.svg'),
                              const SizedBox(width: 20),
                              const Text('Холбоо барих'),
                            ],
                          ),
                          const Opacity(opacity: 0.5, child: Icon(Icons.arrow_forward_ios_rounded))
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    quit(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('images/UserExit.svg'),
                              const SizedBox(width: 20),
                              const Text('Гарах'),
                            ],
                          ),
                          const Opacity(opacity: 0.5, child: Icon(Icons.arrow_forward_ios_rounded))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
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
                const Text('Та гарахдаа итгэлтэй байна уу?', textAlign: TextAlign.center),
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
                            Text('Үгүй', style: TextStyle(color: Colors.white, fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Helper.saveUserLoggedInSharedPreference(false);
                        await Helper.clearToken();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Login()));
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
      }
      );
}
