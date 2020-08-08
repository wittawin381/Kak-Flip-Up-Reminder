import 'package:demo/screenconfig/screen.dart';
import 'package:flutter/material.dart';

typedef OnPresseds = void Function();

class CircleButton extends StatefulWidget {
  CircleButton({this.onPressed, this.icon, this.size = 80});
  final OnPresseds onPressed;
  final Icon icon;
  final double size;
  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(20),
      height: widget.size * Screen.height,
      width: widget.size * Screen.width,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffe0e5ec),
          boxShadow: [
            BoxShadow(
                blurRadius: 16,
                spreadRadius: 1,
                offset: Offset(4, 4),
                color: Color(0xffa3b1c6)),
            BoxShadow(
                blurRadius: 16,
                spreadRadius: 1,
                offset: Offset(-4, -4),
                color: Color(0xffffffff))
          ]),
      child: IconButton(
        icon: widget.icon,
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }
}
