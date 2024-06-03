import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Positioned(
            child: Container(
              width: double.infinity,
              height: 63,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: GestureDetector(
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber('72220111');
                },
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    SvgPicture.asset(
                      'images/Call.svg',
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Call 72220111',
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Positioned(
            child: Container(
                width: double.infinity,
                height: 63,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
    ;
  }
}
