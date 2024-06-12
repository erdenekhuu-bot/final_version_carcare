import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_pro/pages/Register/SignUp.dart';
import 'package:final_pro/usable/MSG/SendMSG.dart';
import 'package:final_pro/pages/Home/MainMenu.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:final_pro/usable/MSG/ForgotPasswordSendMSG.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:another_flushbar/flushbar.dart';
class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  bool _check = false;
  bool _limit = false;
  String _phone = '';
  String _password = '';
  final TextEditingController _cnt1 = TextEditingController();
  final TextEditingController _cnt2 = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _cnt1.dispose();
    _cnt2.dispose();
  }
  final _fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: ListView(
        addAutomaticKeepAlives: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'images/Logo.svg',
                    color: const Color(0xff404040),
                  )
                ],
              ),
              const Text('Car Car',
                  style: TextStyle(
                      color: Color(0xff404040),
                      fontFamily: 'Inter-ExtraBold',
                      fontSize: 25)),
              const SizedBox(height: 10),
              Form(
                key: _fkey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 313,
                          height: 70,
                          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Stack(
                            children: <Widget>[
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Утасны дугаар оруулах шаардлагатай';
                                  }
                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                maxLength: 8,
                                keyboardType: TextInputType.number,
                                controller: _cnt1,
                                onChanged: (value) {
                                  setState(() {
                                    _phone = _cnt1.text;
                                    if (value.length < 8) {
                                      _limit = !_limit;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: const Color(0xff404040).withOpacity(0.5),
                                    ),
                                  ),
                                  labelText: 'Утасны дугаар',
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  labelStyle: const TextStyle(fontFamily: 'Inter-Light'),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset('images/person.svg'),
                                  ),
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 313,
                          height: 70, // Fixed height to prevent layout changes
                          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Stack(
                            children: <Widget>[
                              TextFormField(
                                maxLength: 20,
                                obscureText: _check ? false : true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Нууц үг оруулах шаардлагатай';
                                  }
                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: _cnt2,
                                onChanged: (value) {
                                  setState(() {
                                    _password = _cnt2.text;
                                  });
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ),
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
                                  labelStyle: const TextStyle(fontFamily: 'Inter-Light'),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  counterText: '',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset('images/lockPassword.svg'),
                                  ),
                                  suffixIcon: Opacity(
                                    opacity: 0.5,
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                        _check ? 'images/eye.svg' : 'images/eye_off.svg',
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _check = !_check;
                                        });
                                      },
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 2),
                    Container(
                      padding: null,
                      width: 313,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordSendMSG(title: 'Нууц үг сэргээх', description: 'Таны бүртгэлтэй дугаар дээр баталгаажуулах код илгээх болно.')));
                            },
                            child: const Text(
                              'Нууц үг сэргээх',
                              style:
                                  TextStyle(fontFamily: 'Inter', fontSize: 13),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 313,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              // if(_fkey.currentState!.validate()){
                              //   String result = await RESTAPI.login(_phone, _password);
                              //   Store.storePhone=_phone;
                              //   Store.storePassword=_password;
                              //   if(result == 'success'){
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => const MainMenu()));
                              //   } else {
                              //     Flushbar(
                              //       backgroundColor: const Color(0xFFFF6E6E),
                              //       flushbarStyle: FlushbarStyle.GROUNDED,
                              //       flushbarPosition: FlushbarPosition.TOP,
                              //       titleText: const Center(
                              //         child: Icon(
                              //           Icons.error_outline,
                              //           color: Colors.white,
                              //           size: 28,
                              //         ),
                              //       ),
                              //       messageText: const Padding(
                              //         padding: EdgeInsets.only(bottom: 20.0),
                              //         child: Text(
                              //           "Утасны дугаар аль эсвэл нууц үг буруу байна",
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(color: Colors.white),
                              //         ),
                              //       ),
                              //       duration: const Duration(seconds: 2),
                              //     ).show(context);
                              //   }
                              // }
                              Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const MainMenu()));
                            },
                            child: const Text(
                              'Нэвтрэх',
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
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 313,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SendMSG(title: 'Бүртгүүлэх', description: 'Таны бүртгүүлэх дугаар дээр баталгаажуулах код илгээх болно')));
                            },
                            child: const Text('Бүртгүүлэх',
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontFamily: 'Inter',
                                    fontSize: 15)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Color(0xffdadada)))),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
