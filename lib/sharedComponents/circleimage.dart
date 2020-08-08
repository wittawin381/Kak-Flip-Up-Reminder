import 'package:flutter/material.dart';

import '../style.dart';

class CircleImage extends StatelessWidget {
  CircleImage({this.image, this.height = 150, this.width = 150});
  final String image;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        width: this.width,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            // boxShadow: [
            //   BoxShadow(
            //       offset: Offset(2, 2),
            //       blurRadius: 4,
            //       spreadRadius: -1,
            //       color: MyStyle.darkSharow),
            //   BoxShadow(
            //       offset: Offset(-2, -2),
            //       blurRadius: 4,
            //       spreadRadius: -1,
            //       color: Colors.white),
            // ],
            // border: Border.all(color: Colors.black, width: 3),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.fill)));
  }
}
