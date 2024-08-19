import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
           GestureDetector(
              onTap: () async {
                Uri uri = Uri.parse('tel:72220111');
                try {
                    if(await canLaunchUrl(uri)){
                      await launchUrl(uri);
                    }
                } catch(error) {
                  return;
                }
              },
              child: Container(
                width: double.infinity,
                height: 63,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.white),
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
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.infinity,
                height: 63,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
