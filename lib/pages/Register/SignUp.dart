import 'package:final_pro/REST/RESTAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Login/Login.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:final_pro/pages/Login/Login.dart';
import 'package:final_pro/usable/Components/Policy.dart';

class SignUp extends StatefulWidget {
  final int id;
  final String phone;

  SignUp({super.key, required this.id, required this.phone});

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

  final RegExp passwordRegExp =
      RegExp(r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[\W_]).{8,}$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'images/iconBack.svg',
            width: 35,
            height: 35,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Text(
                'Бүртгүүлэх',
                style: TextStyle(
                    color: Color(0xff404040),
                    fontFamily: 'Inter-Bold',
                    fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  'Та өөрийн нэр болон нууц үгийг оруулна уу.',
                  style: TextStyle(
                      color: Color(0xff404040),
                      fontSize: 13,
                      fontFamily: 'Inter'),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 313,
                      height: 50,
                      child: TextFormField(
                        controller: _digit1,
                        focusNode: f1,
                        onChanged: (text) {
                          _username = _digit1.text;
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: const Color(0xff404040)
                                        .withOpacity(0.5))),
                            labelText: 'Нэр',
                            labelStyle:
                                const TextStyle(fontFamily: 'Inter-Light'),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            counterText: '',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('images/person.svg'),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xffE2E2E2)))),
                        maxLength: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 313,
                      height: 50,
                      child: TextFormField(
                        focusNode: f2,
                        controller: _digit2,
                        onChanged: (value) {
                          setState(() {
                            _password = _digit2.text;
                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: const Color(0xff404040)
                                        .withOpacity(0.5))),
                            labelText: 'Нууц үг',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle:
                                const TextStyle(fontFamily: 'Inter-Light'),
                            counterText: '',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  SvgPicture.asset('images/lockPassword.svg'),
                            ),
                            suffixIcon: Opacity(
                              opacity: 0.5,
                              child: IconButton(
                                  icon: SvgPicture.asset(_passHide
                                      ? 'images/eye.svg'
                                      : 'images/eye_off.svg'),
                                  onPressed: () {
                                    setState(() {
                                      _passHide = !_passHide;
                                    });
                                  }),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xffE2E2E2)))),
                        maxLength: 20,
                        obscureText: _passHide ? false : true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 313,
                      height: 50,
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {
                            _confirmPassword = _digit3.text;
                          });
                        },
                        focusNode: f3,
                        controller: _digit3,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: const Color(0xff404040)
                                        .withOpacity(0.5))),
                            labelText: 'Нууц үг давтах',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle:
                                const TextStyle(fontFamily: 'Inter-Light'),
                            counterText: '',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  SvgPicture.asset('images/lockPassword.svg'),
                            ),
                            suffixIcon: Opacity(
                              opacity: 0.5,
                              child: IconButton(
                                  icon: SvgPicture.asset(_confirmHide
                                      ? 'images/eye.svg'
                                      : 'images/eye_off.svg'),
                                  onPressed: () {
                                    setState(() {
                                      _confirmHide = !_confirmHide;
                                    });
                                  }),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xffE2E2E2)))),
                        maxLength: 20,
                        obscureText: _confirmHide ? false : true,
                      ),
                    ),
                    const SizedBox(height: 45),
                    SizedBox(
                      width: 313,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (passwordRegExp.hasMatch(_confirmPassword)) {
                            String result = await RESTAPI.createUser(widget.id,
                                _username, _confirmPassword, widget.phone);
                            if (result == 'success') {
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
                                  "Баталгаажуулах код буруу байна",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              duration: const Duration(seconds: 2),
                            ).show(context);
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
