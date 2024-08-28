import 'package:flutter/material.dart';
import 'package:final_pro/REST/RESTAPI.dart';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/usable/Components/MySelfPhone.dart';
import 'package:flutter/services.dart';

class ChangePhoneValidateMSG extends StatefulWidget {
  final String? phoneNumber;

  ChangePhoneValidateMSG({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<ChangePhoneValidateMSG> createState() => _ChangePhoneValidateMSGState();
}

class _ChangePhoneValidateMSGState extends State<ChangePhoneValidateMSG> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String result = '';

  @override
  void dispose() {
    for (var controller in _controllers) controller.dispose();
    for (var focusNode in _focusNodes) focusNode.dispose();
    super.dispose();
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _handleTextChanged(String value, int index) {
    if (value.length == 1) {
      if (index < _controllers.length - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else if (value.isEmpty) {
      _handleBackspace(index);
    }
    setState(() {
      result = _controllers.map((controller) => controller.text).join();
    });
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: MediaQuery.of(context).size.width / 10,
      height: MediaQuery.of(context).size.width / 10,
      margin: const EdgeInsets.symmetric(horizontal: 6.5),
      child: TextFormField(
        focusNode: _focusNodes[index],
        controller: _controllers[index],
        maxLength: 1,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) => _handleTextChanged(value, index),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 1,
              color: const Color(0xff404040).withOpacity(0.5),
            ),
          ),
          border: const OutlineInputBorder(),
          counterText: '',
        ),
      ),
    );
  }

  Future<void> _verifyOtp() async {
    String otp = _controllers.map((controller) => controller.text).join();
    int response = await RESTAPI.verifyOTP(otp, widget.phoneNumber!);
    if (response > 0) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => MySelfPhone(
          password: Store.storePassword,
          phone: Store.storePhone,
          username: Store.storeUsername,
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFFF6E6E),
          content: Row(
            children: const [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text('Баталгаажуулах код буруу байна', style: TextStyle(color: Colors.white))),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _resendOtp() async {
    final int id = await RESTAPI.sendOTP(widget.phoneNumber!);
    if (id > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF41D4A8),
          content: Row(
            children: const [
              Icon(Icons.check_circle_outline_rounded, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text('Баталгаажуулах код ахин илгээлээ', style: TextStyle(color: Colors.white))),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Center(
              child: Text(
                'Дугаар баталгаажуулах',
                style: TextStyle(color: Color(0xff404040), fontFamily: 'Inter-Bold', fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                '${widget.phoneNumber} дугаарт 6 оронтой код илгээлээ',
                style: TextStyle(color: Color(0xff404040), fontSize: 13, fontFamily: 'Inter'),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) => _buildOtpField(index)),
            ),
            SizedBox(height: 15),
            Center(
              child: SizedBox(
                width: screenWidth * 0.78,
                height: 40,
                child: ElevatedButton(
                  onPressed: _verifyOtp,
                  child: const Text(
                    'Үргэлжлүүлэх',
                    style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff404040),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: _resendOtp,
                child: const Text(
                  'Дахин илгээх',
                  style: TextStyle(fontFamily: 'Inter-Light', color: Color(0xff404040), decoration: TextDecoration.underline, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
