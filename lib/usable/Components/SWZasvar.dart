import 'package:flutter/material.dart';
import 'Fix.dart';

class SWZasvar extends StatelessWidget {
  const SWZasvar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      child: const TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Fix(phone: '90831112'),
                  ],
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Move(phone: '90831112'),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
