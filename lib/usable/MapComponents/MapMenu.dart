import 'package:flutter/material.dart';

class MapFirstMenu extends StatelessWidget {
  final String name;
  const MapFirstMenu({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(

        width: MediaQuery.of(context).orientation == Orientation.portrait ? 152 : 252,
        height: 40,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).orientation == Orientation.portrait ? 192 : 292,
      height: 40,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
        color: const Color(0xff404040).withOpacity(0.8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(name, style: const TextStyle(color: Colors.white))
      ]),
    );
  }
}
