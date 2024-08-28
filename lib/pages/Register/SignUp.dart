import 'package:final_pro/REST/RESTAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:final_pro/usable/Components/Policy.dart';

class SignUp extends StatefulWidget {
  final int? id;
  final String? phone;

  SignUp({super.key, this.id, this.phone});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _digit1 = TextEditingController();
  final TextEditingController _digit2 = TextEditingController();
  final TextEditingController _digit3 = TextEditingController();
  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String _password = "";
  String _confirmPassword = "";

  bool _passHide = false;
  bool _confirmHide = false;
  @override
  void dispose() {
    super.dispose();
    _digit1.dispose();
    _digit2.dispose();
    _digit3.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
  }

  final hasUpperCase = RegExp(r'[A-Z]');
  final hasLowerCase = RegExp(r'[a-z]');
  final hasDigit = RegExp(r'[0-9]');
  final hasSpecialChar = RegExp(r'[\W_]');


  Widget f10(){
  return  Container(
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
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Text('Бүртгүүлэх', style: TextStyle(color: Color(0xff404040), fontFamily: 'Inter-Bold', fontSize: 20)),
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text('Та өөрийн нэр болон нууц үгийг оруулна уу.', style: TextStyle(color: Color(0xff404040), fontSize: 13, fontFamily: 'Inter')),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: screenWidth * 0.78,
                      height: 80,
                      child: TextFormField(
                        controller: _digit1,
                        focusNode: f1,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Нэрээ оруулна уу';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (text) {
                          _username = _digit1.text;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5),
                            ),
                          ),
                          labelText: 'Нэр',
                          labelStyle: const TextStyle(fontFamily: 'Inter-Light'),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          counterText: '',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset('images/person.svg'),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xffE2E2E2)),
                          ),
                        ),
                        maxLength: 20,
                      ),
                    ),

                    const SizedBox(height: 5),
                    SizedBox(
                      width: screenWidth * 0.78,
                      height: 80,
                      child: TextFormField(
                        focusNode: f2,
                        controller: _digit2,
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
                            _password = _digit2.text;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5),
                            ),
                          ),
                          labelText: 'Нууц үг',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: const TextStyle(fontFamily: 'Inter-Light'),
                          counterText: '',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset('images/lockPassword.svg'),
                          ),
                          suffixIcon: Opacity(
                            opacity: 0.5,
                            child: IconButton(
                              icon: SvgPicture.asset(_passHide ? 'images/eye.svg' : 'images/eye_off.svg'),
                              onPressed: () {
                                setState(() {
                                  _passHide = !_passHide;
                                });
                              },
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xffE2E2E2)),
                          ),
                        ),
                        maxLength: 20,
                        obscureText: _passHide ? false : true,
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
                        onChanged: (text) {
                          setState(() {
                            _confirmPassword = _digit3.text;
                          });
                        },
                        focusNode: f3,
                        controller: _digit3,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: const Color(0xff404040).withOpacity(0.5),
                            ),
                          ),
                          labelText: 'Нууц үг давтах',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: const TextStyle(fontFamily: 'Inter-Light'),
                          counterText: '',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset('images/lockPassword.svg'),
                          ),
                          suffixIcon: Opacity(
                            opacity: 0.5,
                            child: IconButton(
                              icon: SvgPicture.asset(_confirmHide ? 'images/eye.svg' : 'images/eye_off.svg'),
                              onPressed: () {
                                setState(() {
                                  _confirmHide = !_confirmHide;
                                });
                              },
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xffE2E2E2)),
                          ),
                        ),
                        maxLength: 20,
                        obscureText: _confirmHide ? false : true,
                      ),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: screenWidth * 0.78,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              if(_digit2.text == _digit3.text){
                                    String result = await RESTAPI.createUser(_username, _confirmPassword, widget.phone!);
                                    if (result != '') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const Policy()));
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
                          'Бүртгүүлэх',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 17),
                        ),
                      ),
                    ),
                    f10()
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
