import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:final_pro/pages/ForgotPassword/ForgotPassword.dart';
import 'package:final_pro/usable/Store/Store.dart';

class ForgotPasswordValidateMSG extends StatefulWidget {
  String phoneNumber;
  ForgotPasswordValidateMSG({super.key, required this.phoneNumber});

  @override
  State<ForgotPasswordValidateMSG> createState() => _ForgotPasswordValidateMSGState();
}

class _ForgotPasswordValidateMSGState extends State<ForgotPasswordValidateMSG> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  child: Text(
                    '${widget.phoneNumber!} дугаарт 6 оронтой код илгээлээ',
                    style: const TextStyle(
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
                  width: screenWidth / 10,
                  height: screenWidth / 10,
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
                  width: screenWidth / 10,
                  height: screenWidth / 10,
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
                  width: screenWidth / 10,
                  height: screenWidth / 10,
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
                  width: screenWidth / 10,
                  height: screenWidth / 10,
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
                  width: screenWidth / 10,
                  height: screenWidth / 10,
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
                  width: screenWidth / 10,
                  height: screenWidth / 10,
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
                  width: screenWidth * 0.78,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      String result = props(_digit1) + props(_digit2) + props(_digit3) + props(_digit4) + props(_digit5) + props(_digit6);
                      int response = await RESTAPI.verifyOTP(result, widget.phoneNumber);
                      if(response > 0){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword(phone: widget.phoneNumber)));
                      } else {
                        Flushbar(
                          backgroundColor: const Color(0xFFFF6E6E),
                          flushbarStyle: FlushbarStyle.GROUNDED,
                          flushbarPosition: FlushbarPosition.TOP,
                          titleText: const Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          messageText: const Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              "Баталгаажуулах код буруу байна",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                        ).show(context);
                      }
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
                  onTap: () async {
                    final int _id = await RESTAPI.sendOTP(widget.phoneNumber);
                    if(_id > 0) {
                      Flushbar(
                        backgroundColor: const Color(0xFF41D4A8),
                        flushbarStyle: FlushbarStyle.GROUNDED,
                        flushbarPosition: FlushbarPosition.TOP,
                        titleText: const Center(
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        messageText: const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Баталгаажуулах код ахин илгээлээ",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                      ).show(context);
                    }
                  },
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
