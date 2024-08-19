import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:final_pro/pages/Login/Login.dart';
import 'package:another_flushbar/flushbar.dart';

class ForgotPassword extends StatefulWidget {
  final int? confirmationId;
  final String? phone;
  ForgotPassword({super.key, this.confirmationId, this.phone});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cnt1 = TextEditingController();
  final TextEditingController _cnt2 = TextEditingController();

  final FocusNode _f1 = FocusNode();
  final FocusNode _f2 = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _cnt1.dispose();
    _cnt2.dispose();
    _f1.dispose();
    _f2.dispose();
  }

  String _password = '';
  String _confirmPassword = '';
  bool _check = false;
  bool _setCheck = false;

  final RegExp passwordRegExp =
      RegExp(r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[\W_]).{8,}$');
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Нууц үг сэргээх',
                      style: TextStyle(
                          color: Color(0xff404040),
                          fontFamily: 'Inter-Bold',
                          fontSize: 20),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'Та нууц үгээ шинээр оруулна уу.',
                    style: TextStyle(
                        color: Color(0xff404040),
                        fontFamily: 'Inter-Light',
                        fontSize: 13),
                  ),
                ),
                const SizedBox(height: 5),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      SizedBox(
                        width: screenWidth * 0.78,
                        height: 80,
                        child: TextFormField(
                          validator: (text) {
                            if (passwordRegExp.hasMatch(text!)) {
                              return null;
                            } else {
                              return 'Хүчтэй нууц үг ашиглана уу';
                            }
                          },
                          obscureText: _check ? false : true,
                          maxLength: 20,
                          onChanged: (value) {
                            setState(() {
                              _password = _cnt1.text;
                            });
                          },
                          controller: _cnt1,
                          focusNode: _f1,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: const Color(0xff404040).withOpacity(0.5),
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            counterText: '',
                            labelText: 'Нууц үг',
                            labelStyle:
                                const TextStyle(fontFamily: 'Inter-Light'),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  SvgPicture.asset('images/lockPassword.svg'),
                            ),
                            suffixIcon: Opacity(
                              opacity: 0.5,
                              child: IconButton(
                                icon: SvgPicture.asset(_check
                                    ? 'images/eye.svg'
                                    : 'images/eye_off.svg'),
                                onPressed: () {
                                  setState(() {
                                    _check = !_check;
                                  });
                                },
                              ),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: screenWidth * 0.78,
                        height: 80,
                        child: TextFormField(
                          validator: (text) {
                            if (passwordRegExp.hasMatch(text!)) {
                              return null;
                            } else {
                              return 'Хүчтэй нууц үг ашиглана уу';
                            }
                          },
                          obscureText: _setCheck ? false : true,
                          maxLength: 20,
                          onChanged: (value) {
                            _confirmPassword = _cnt2.text;
                          },
                          controller: _cnt2,
                          focusNode: _f2,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: const Color(0xff404040).withOpacity(0.5),
                              ),
                            ),
                            counterText: '',
                            labelText: 'Нууц үг давтах',
                            labelStyle:
                                const TextStyle(fontFamily: 'Inter-Light'),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  SvgPicture.asset('images/lockPassword.svg'),
                            ),
                            suffixIcon: Opacity(
                              opacity: 0.5,
                              child: IconButton(
                                icon: SvgPicture.asset(_setCheck
                                    ? 'images/eye.svg'
                                    : 'images/eye_off.svg'),
                                onPressed: () {
                                  setState(() {
                                    _setCheck = !_setCheck;
                                  });
                                },
                              ),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: screenWidth / 30)
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.78,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_cnt1.text == _cnt2.text) {
                          String result = await RESTAPI.forgotPassword(
                              widget.phone!, _confirmPassword);
                          if (result != '') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
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
                                  "Нууц үг амжилттай сэргээгдлээ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              duration: const Duration(seconds: 2),
                            ).show(context);
                          }
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
                                "Давтсан оруулсан нууц үг буруу байна",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                          ).show(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff404040),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Үргэлжлүүлэх',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter-Regular',
                          fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
