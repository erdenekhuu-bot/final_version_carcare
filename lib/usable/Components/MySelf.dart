import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/usable/MSG/ChangePhoneSendMSG.dart';
import 'package:final_pro/REST/AuthService.dart';
import 'package:final_pro/usable/Components/Helper.dart';

class MySelf extends StatefulWidget {
  final String? token;
  final String? phone;
  final String? username;
  final String? password;
  final void Function()? onNavigateToUser;
  MySelf(
      {super.key,
      this.token,
      this.password,
      this.username,
      this.phone,
      this.onNavigateToUser});

  @override
  State<MySelf> createState() => _MySelfState();
}

class _MySelfState extends State<MySelf> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tnt1 = TextEditingController();
  final TextEditingController _tnt2 = TextEditingController();
  final TextEditingController _tnt3 = TextEditingController();

  final FocusNode _f1 = FocusNode();
  final FocusNode _f2 = FocusNode();
  final FocusNode _f3 = FocusNode();

  String setUsername = '';
  String setPassword = '';
  String privatePhone = '';

  String username = '';
  String phone = '';
  String password = '';

  void f1() async {
    String fetchedUsername = await Store.username();
    String fetchedPhone = await Store.phone();
    String fetchedPassword = await Store.password();
      setState(() {
        username=fetchedUsername;
        phone=fetchedPhone;
        password=fetchedPassword;
      });
  }

  bool _obscureTextNewPass = false;
  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureTextNewPass = !_obscureTextNewPass;
    });
  }

  String generateDot() {
    return '*' * password.length;
  }

  int forward = 0;

  @override
  Widget build(BuildContext context) {
    f1();
    final hasUpperCase = RegExp(r'[A-Z]');
    final hasLowerCase = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'[0-9]');
    final hasSpecialChar = RegExp(r'[\W_]');
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(  
        children: [ 
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text('Хувийн мэдээлэл',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF404040))),
          ),
          SizedBox(height: screenHeight / 90),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: null,
                  width: screenWidth * 0.78,
                  height: 40,
                  child: const Row(
                    children: [
                      Text('Нэр ',
                          style: TextStyle(
                              fontFamily: 'Inter-Light', fontSize: 15)),
                    ],
                  ),
                ),
                Container(
                  padding: null,
                  width: screenWidth * 0.78,
                  height: 50,
                  child: SizedBox(
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {
                          setUsername = _tnt1.text;
                        });
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Нэрээ оруулна уу';
                        } else {
                          return null;
                        }
                      },
                      controller: _tnt1,
                      focusNode: _f1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: '${username}',
                        labelStyle: const TextStyle(
                            fontFamily: 'Inter-Light',
                            color: Color(0xFF404040),
                            fontSize: 15,
                            height: 0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'images/person.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    const Color(0xff404040).withOpacity(0.5))),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: null,
                  width: screenWidth * 0.78,
                  height: 40,
                  child: const Row(
                    children: [
                      Text('Утасны дугаар',
                          style: TextStyle(
                              fontFamily: 'Inter-Light', fontSize: 15)),
                    ],
                  ),
                ),
                forward == 0
                    ? Container(
                        padding: null,
                        width: screenWidth * 0.78,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.5), width: 1.0),
                          ),
                          height: 60,
                          child: GestureDetector(
                            onTap: null,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'images/UserCall.svg',
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${phone}',
                                        style: TextStyle(
                                            fontFamily: 'Inter-Light',
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangePhoneSendMSG(
                                                    title: 'Дугаар өөрчлөх',
                                                    description:
                                                        'Таны өөрчлөх дугаар дээр баталгаажуулах код илгээх болно.',
                                                  )));
                                      // setState(() {
                                      //   forward = 1;
                                      // });
                                    },
                                    icon: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SvgPicture.asset('images/edit.svg')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: null,
                        width: screenWidth * 0.78,
                        height: 50,
                        child: SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 8,
                            onChanged: (text) {
                              setState(() {
                                privatePhone = _tnt3.text;
                              });
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Утасны дугаараа оруулна уу';
                              } else {
                                return null;
                              }
                            },
                            controller: _tnt3,
                            focusNode: _f3,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: '${phone}',
                              counterText: '',
                              labelStyle: TextStyle(
                                fontFamily: 'Inter-Light',
                                color: Colors.black.withOpacity(0.5),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'images/person.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: const Color(0xff404040)
                                          .withOpacity(0.5))),
                            ),
                          ),
                        ),
                      ),
                Container(
                  padding: null,
                  width: screenWidth * 0.78,
                  height: 40,
                  child: const Row(
                    children: [
                      Text(
                        'Нууц үг',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: null,
                  width: screenWidth * 0.78,
                  height: 70,
                  child: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Нууц үгээ оруулна уу';
                      } else if (!hasUpperCase.hasMatch(text)) {
                        return 'Том үсэг оруулна уу';
                      } else if (!hasLowerCase.hasMatch(text)) {
                        return 'Жижиг үсэг оруулна уу';
                      } else if (!hasDigit.hasMatch(text)) {
                        return 'Тоо оруулна уу';
                      } else if (!hasSpecialChar.hasMatch(text)) {
                        return 'Тусгай тэмдэгт оруулна уу';
                      } else if (text.length < 8) {
                        return 'Хамгийн багадаа 8 тэмдэгт оруулна уу';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        setPassword = _tnt2.text;
                      });
                    },
                    controller: _tnt2,
                    focusNode: _f2,
                    maxLength: 20,
                    obscureText: _obscureTextNewPass ? false : true,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      counterText: '',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: _obscureTextNewPass
                          ? '${password}'
                          : generateDot(),
                      labelStyle: const TextStyle(
                          color: Color(0xFF404040), fontSize: 18, height: 0),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset('images/lockPassword.svg'),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: Opacity(
                        opacity: 0.5,
                        child: IconButton(
                          icon: _obscureTextNewPass
                              ? SvgPicture.asset('images/eye.svg')
                              : SvgPicture.asset('images/eye_off.svg'),
                          onPressed: _toggleNewPasswordVisibility,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xffE2E2E2)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                    padding: null,
                    width: screenWidth * 0.78,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff404040),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        String? access=await Helper.readDefaultToken();
                        String? refresh=await Helper.readToken();
                        AuthService authService = AuthService(access!, refresh!);
                        if (_formKey.currentState!.validate()) {
                          privatePhone == '' ? privatePhone = Store.storePhone : '';
                          String _result = await authService.updateUser(setUsername, privatePhone, setPassword);
                          if (_result != '') {
                            Navigator.pop(context, true);
                            Flushbar(
                              backgroundColor: Color(0xFF50C878),
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              flushbarPosition: FlushbarPosition.TOP,
                              titleText: Center(
                                child: Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              messageText: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  "Хувийн мэдээлэл амжилттай хадгалагдлаа",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              duration: Duration(seconds: 2),
                            )..show(context);
                          } else {
                            Flushbar(
                              backgroundColor: const Color(0xFFFF6E6E),
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              flushbarPosition: FlushbarPosition.TOP,
                              titleText: const Center(
                                  child: Icon(Icons.error_outline,
                                      color: Colors.white, size: 28)),
                              messageText: const Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                    "Нэр, нууц үгээ оруулах шаардлагатай",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white)),
                              ),
                              duration: const Duration(seconds: 2),
                            ).show(context);
                          }
                        }
                      },
                      child: const Text('Хадгалах',
                          style: TextStyle(
                              fontFamily: 'Inter-Light',
                              fontSize: 17,
                              color: Colors.white)),
                    )),
                    Container(
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'Тавигдах шаардлага',
                              style: TextStyle(
                                color: Color(0xff404040),
                                fontFamily: 'Inter-Regular',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Том үсэг:',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                SizedBox(width: 10),
                                Text('A, B, C, D, E, F ...', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text(
                                    'Жижиг үсэг:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                SizedBox(width: 10), Text(
                                    'a, b, c, d, e, f ...',
                                    style: TextStyle(fontSize: 16),
                                  ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text(
                                    'Тоо:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),

                                ),
                                SizedBox(width: 10),
                                Text(
                                    '1, 2, 3, 4, 5, 6 ...',
                                    style: TextStyle(fontSize: 16),
                                  ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text(
                                    'Тусгай тэмдэгт:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                SizedBox(width: 10),Text(
                                    '~, !, @, #, %, ^ ...',
                                    style: TextStyle(fontSize: 16),
                                  ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Анхаарах зүйл',
                              style: TextStyle(
                                color: Color(0xff404040),
                                fontFamily: 'Inter-Regular',
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Нууц үг зохихдоо 8 үсэг тэмдэгтүүдээс илүү олон байх шаардлагатай !!',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
              ],
            ),
          )
        ],
      ),
        ],
      )
    );
  }
}
