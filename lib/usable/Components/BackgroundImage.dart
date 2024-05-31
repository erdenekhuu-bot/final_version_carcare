import 'package:flutter/material.dart';

Widget buildImage(String urlImage, int index) => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox.fromSize(
        child: Image.asset(
          urlImage,
        ),
      ),
    );
