import 'package:flutter/material.dart';

class MapFirstMenu extends StatelessWidget {
  final String name;
  final VoidCallback? f1;
  MapFirstMenu({super.key, required this.name, this.f1});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth * 0.4,
        height: 40,
        decoration: BoxDecoration(
            border: const Border(bottom: BorderSide(width: 1, color: Colors.white)),
            color: const Color(0xff404040).withOpacity(0.8),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}

class MapSecondMenu extends StatelessWidget {
  final String name;
  const MapSecondMenu({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

   return Container(
     padding: const EdgeInsets.symmetric(horizontal: 10),
     width: screenWidth * 0.4,
     height: 40,
     decoration: BoxDecoration(
       border: const Border(bottom: BorderSide(width: 1, color: Colors.white)),
       color: const Color(0xff404040).withOpacity(0.8),
       borderRadius: BorderRadius.circular(5),
     ),
     child: Center(
       child: Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white), softWrap: true),
     ),
   );
  }
}
