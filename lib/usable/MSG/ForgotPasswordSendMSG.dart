
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_flags/country_flags.dart';
import 'ValidateMSG.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'dart:convert';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/usable/MSG/ForgotPasswordValidateMSG.dart';
class ForgotPasswordSendMSG extends StatefulWidget {

  final String? title;
  final String? description;
  const ForgotPasswordSendMSG({super.key, this.description, this.title});

  @override
  State<ForgotPasswordSendMSG> createState() => _ForgotPasswordSendMSGState();
}

class _ForgotPasswordSendMSGState extends State<ForgotPasswordSendMSG> {
  final _formkey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  bool _limit = false;
  String _phoneNumber = '';
  final TextEditingController _controller = TextEditingController();

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'images/iconBack.svg',
            width: 35,
            height: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          addAutomaticKeepAlives: true,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.title}',
                      style: TextStyle(
                          color: Color(0xff404040),
                          fontFamily: 'Inter-Bold',
                          fontSize: 20),
                    )
                  ],
                ),
                Container(
                  width: 315,
                  margin: const EdgeInsets.all(12),
                  child: Text(
                    '${widget.description}',
                    style: TextStyle(
                        color: Color(0xff404040),
                        fontSize: 13,
                        fontFamily: 'Inter'),
                  ),
                ),
                SizedBox(
                  width: 313,
                  height: 40,
                  child: Opacity(
                    opacity: 0.7,
                    child: TextFormField(
                      focusNode: _focusNode,
                      onChanged: (phone) {
                        setState(() {
                          if (phone.length < 8) {
                            _limit = false;
                          } else {
                            _limit = true;
                          }
                          _phoneNumber = _controller.text;
                        });
                      },
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          fillColor: Colors.white,
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          counterText: '',
                          prefixIcon: SizedBox(
                            width: 90,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15, 8, 8, 8),
                                  child: CountryFlag.fromCountryCode(
                                    'MN',
                                    width: 30,
                                    height: 30,
                                    borderRadius: 5,
                                  ),
                                ),
                                const Text('+976')
                              ],
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: const Color(0xff404040)
                                      .withOpacity(0.5)))),
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                SizedBox(
                  width: 313,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _limit ? () async {
                      final int _id = await RESTAPI.sendOTP(_phoneNumber);
                      if(_id > 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordValidateMSG(confirmationId: _id, phoneNumber: _phoneNumber)));
                      }
                    } : null,
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
