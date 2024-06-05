import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cnt1 = TextEditingController();
  final TextEditingController _cnt2 = TextEditingController();

  FocusNode _f1 = FocusNode();
  FocusNode _f2 = FocusNode();

  @override
  void dispose(){
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: SvgPicture.asset(
        //     'images/iconBack.svg',
        //     width: 35,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Column(
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
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
              'Та нууц үгээ шинээр оруулна уу.',
              style: TextStyle(
                  color: Color(0xff404040),
                  fontFamily: 'Inter-Light',
                  fontSize: 13),
            ),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: 313,
                  height: 50,
                  child: TextFormField(
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
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1,
                                color: const Color(0xff404040)
                                    .withOpacity(0.5))),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        counterText: '',
                        labelText: 'Нууц үг',
                        labelStyle: const TextStyle(fontFamily: 'Inter-Light'),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset('images/lockPassword.svg'),
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
                              }),
                        ),
                        border: const OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 313,
                  height: 50,
                  child: TextFormField(
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
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1,
                                color: const Color(0xff404040)
                                    .withOpacity(0.5))),
                        counterText: '',
                        labelText: 'Нууц үг давтах',
                        labelStyle: const TextStyle(fontFamily: 'Inter-Light'),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset('images/lockPassword.svg'),
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
                              }),
                        ),
                        border: const OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          SizedBox(
              width: 313,
              height: 40,
              child: ElevatedButton(
                // onPressed: () async {
                //   String result = await _forgotPass(_confirmPassword);
                //   if (result == 'success') {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => const SignIn()));
                //   } else {
                //     print(result);
                //   }
                // },
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff404040),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text(
                  'Үргэлжлүүлэх',
                  style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 17),
                ),
              ),
          )
        ],
      ),
    );
  }
}

