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

  final hasUpperCase = RegExp(r'[A-Z]');
  final hasLowerCase = RegExp(r'[a-z]');
  final hasDigit = RegExp(r'[0-9]');
  final hasSpecialChar = RegExp(r'[\W_]');


Widget f1(){
  return Container(
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
  );

}




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
                  child: const Text('Та нууц үгээ шинээр оруулна уу.', style: TextStyle(color: Color(0xff404040), fontFamily: 'Inter-Light', fontSize: 13)),
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
                ), 
                f1()
              ],
            ),
          ],
        ));
  }
}
