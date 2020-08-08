import 'package:flutter/material.dart';

class Screen {
  static double width;
  static double height;
  static double scale;
  void init(BuildContext context) {
    width = MediaQuery.of(context).size.width / 480;
    scale = MediaQuery.of(context).size.width / 480;

    // print(MediaQuery.of(context).size.height * MediaQuery.of(context).devicePixelRatio);
    height = MediaQuery.of(context).size.height / 805.3;
  }
}
