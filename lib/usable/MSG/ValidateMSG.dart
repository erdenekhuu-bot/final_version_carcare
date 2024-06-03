import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/pages/Register/SignUp.dart';
import 'package:another_flushbar/flushbar.dart';

class ValidateMsg extends StatefulWidget {
  const ValidateMsg({super.key});

  @override
  State<ValidateMsg> createState() => _ValidateMsgState();
}

class _ValidateMsgState extends State<ValidateMsg> {
  final _k = GlobalKey<FormState>();
  String result = '';

  final TextEditingController _digit1 = TextEditingController();
  final TextEditingController _digit2 = TextEditingController();
  final TextEditingController _digit3 = TextEditingController();
  final TextEditingController _digit4 = TextEditingController();
  final TextEditingController _digit5 = TextEditingController();
  final TextEditingController _digit6 = TextEditingController();

  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();
  final FocusNode f5 = FocusNode();
  final FocusNode f6 = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _digit1.dispose();
    _digit2.dispose();
    _digit3.dispose();
    _digit4.dispose();
    _digit5.dispose();
    _digit6.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    f6.dispose();
  }

  String props(TextEditingController controller) {
    return controller.text;
  }

  bool check = false;
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset(
            'images/iconBack.svg',
            width: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _k,
        child: ListView(
          addAutomaticKeepAlives: true,
          children: [
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Дугаар баталгаажуулах',
                      style: TextStyle(
                          color: Color(0xff404040),
                          fontFamily: 'Inter-Bold',
                          fontSize: 20),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    '86999042 дугаарт 6 оронтой код илгээлээ',
                    style: TextStyle(
                        color: Color(0xff404040),
                        fontSize: 13,
                        fontFamily: 'Inter'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 6.5),
                  child: TextFormField(
                    focusNode: f1,
                    controller: _digit1,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) {
                        result = value;
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5))),
                      labelText: '',
                      counterText: '',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 6.5),
                  child: TextFormField(
                    focusNode: f2,
                    controller: _digit2,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) {
                        result = value;
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5))),
                      labelText: '',
                      counterText: '',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 6.5),
                  child: TextFormField(
                    focusNode: f3,
                    controller: _digit3,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) {
                        result = value;
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5))),
                      labelText: '',
                      counterText: '',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 6.5),
                  child: TextFormField(
                    focusNode: f4,
                    controller: _digit4,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) {
                        result = value;
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5))),
                      labelText: '',
                      counterText: '',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 6.5),
                  child: TextFormField(
                    focusNode: f5,
                    controller: _digit5,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) {
                        result = value;
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5))),
                      labelText: '',
                      counterText: '',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 6.5),
                  child: TextFormField(
                    focusNode: f6,
                    controller: _digit6,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) {
                        result = value;
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5))),
                      labelText: '',
                      counterText: '',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 313,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Text(
                      'Үргэлжлүүлэх',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff404040),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Дахин илгээх',
                    style: TextStyle(
                        fontFamily: 'Inter-Light',
                        color: Color(0xff404040),
                        decoration: TextDecoration.underline,
                        fontSize: 13),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
