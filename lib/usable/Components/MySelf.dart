import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MySelf extends StatefulWidget {
  final String? token;
  final int? forward;
  const MySelf({super.key, this.token, this.forward});

  @override
  State<MySelf> createState() => _MySelfState();
}

class _MySelfState extends State<MySelf> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _tnt1 = TextEditingController();
  TextEditingController _tnt2 = TextEditingController();
  TextEditingController _tnt3 = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: SvgPicture.asset(
        //     'images/iconBack.svg',
        //     width: 35,
        //     height: 35,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('Хувийн мэдээлэл',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF404040))),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: null,
                  width: 313,
                  height: 40,
                  child: const Row(
                    children: [
                      Text(
                        'Нэр ',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: null,
                  width: 313,
                  height: 50,
                  child: SizedBox(
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {
                          setUsername = _tnt1.text;
                        });
                      },
                      controller: _tnt1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'username',
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
                const SizedBox(height: 10),
                Container(
                  margin: null,
                  width: 313,
                  height: 40,
                  child: const Row(
                    children: [
                      Text(
                        'Утасны дугаар',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.forward != 1
                    ? Container(
                        padding: null,
                        width: 313,
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
                              padding: const EdgeInsets.only(left: 13),
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
                                        width: 20,
                                      ),
                                      Text(
                                        '$phone',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const changeNumber(),
                                      //   ),
                                      // );
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
                        width: 313,
                        height: 50,
                        child: SizedBox(
                          child: TextFormField(
                            maxLength: 8,
                            onChanged: (text) {
                              setState(() {
                                privatePhone = _tnt3.text;
                              });
                            },
                            controller: _tnt3,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: '$phone',
                              counterText: '',
                              labelStyle: const TextStyle(
                                  color: Color(0xFF404040),
                                  fontSize: 18,
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
                const SizedBox(height: 10),
                Container(
                  padding: null,
                  width: 313,
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
                  width: 313,
                  height: 50,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        setPassword = _tnt2.text;
                      });
                    },
                    controller: _tnt2,
                    maxLength: 20,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      counterText: '',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      // hintText: _obscureTextNewPass
                      //     ? '${StoreToken.showPasswordForProfile}'
                      //     : generateDot(),
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
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
