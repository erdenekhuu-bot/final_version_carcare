import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/pages/Login/Login.dart';
import 'package:final_pro/usable/MSG/ChangePhoneSendMSG.dart';

class MySelf extends StatefulWidget {
  final String? token;
  final int? forward;
  final String? phone;
  final String? username;
  final String? password;
  MySelf(
      {super.key,
      this.token,
      this.forward,
      this.password,
      this.username,
      this.phone});

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

  String username = '';
  String phone = '';
  String password = '';

  String setUsername = '';
  String setPassword = '';
  String privatePhone = '';

  bool _obscureTextNewPass = false;
  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureTextNewPass = !_obscureTextNewPass;
    });
  }

  String generateDot() {
    return '*' * Store.storePassword.length;
  }

  bool _passHide = false;

  @override
  Widget build(BuildContext context) {
    final RegExp passwordRegExp = RegExp(r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[\W_]).{8,}$');
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
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
                      controller: _tnt1,
                      focusNode: _f1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: '${widget.username}',
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
                      Text(
                        'Утасны дугаар',
                        style: TextStyle(
                          fontFamily: 'Inter-Light',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.forward != 1
                    ? Container(
                        padding: null,
                        width: screenWidth * 0.78,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                              width: 1.0,
                            ),
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.phone}',
                                        style: TextStyle(
                                          fontFamily: 'Inter-Light',
                                          color: Colors.black.withOpacity(0.5),
                                        ),
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
                                        child:
                                            SvgPicture.asset('images/edit.svg'),
                                      ),
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
                            controller: _tnt3,
                            focusNode: _f3,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: '${widget.phone}',
                              counterText: '',
                              labelStyle: TextStyle(fontFamily: 'Inter-Light',
                                color: Colors.black.withOpacity(0.5),),
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
                      if (passwordRegExp.hasMatch(text!)) {
                        return null;
                      } else {
                        return 'Хүчтэй нууц үг ашиглана уу';
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
                          ? '${Store.storePassword}'
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
                       if(_formKey.currentState!.validate()){
                         privatePhone == '' ? privatePhone = Store.storePhone : '';
                         String _result = await RESTAPI.updateUser(
                             Store.confirmationId,
                             setUsername,
                             privatePhone,
                             setPassword);
                         if (_result == 'success') {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => const Login()));
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
                               child: Icon(
                                 Icons.error_outline,
                                 color: Colors.white,
                                 size: 28,
                               ),
                             ),
                             messageText: const Padding(
                               padding: EdgeInsets.only(bottom: 20.0),
                               child: Text(
                                 "Нэр, нууц үгээ оруулах шаардлагатай",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(color: Colors.white),
                               ),
                             ),
                             duration: const Duration(seconds: 2),
                           ).show(context);
                         }
                       }
                      },
                      child: const Text(
                        'Хадгалах',
                        style: TextStyle(
                            fontFamily: 'Inter-Light',
                            fontSize: 17,
                            color: Colors.white),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
