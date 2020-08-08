import 'package:flutter/material.dart';
import '../posture/postureView.dart';

Route customRoute(dynamic view, dynamic exView) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var exitBegin = Offset(0.0, 0.0);
        var exitEnd = Offset(-0.3, 0.0);
        var curve = Curves.linearToEaseOut;
        var exitTween = Tween(begin: exitBegin, end: exitEnd)
            .chain(CurveTween(curve: Curves.easeInOut));
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return Stack(children: [
          SlideTransition(
            position: animation.drive(exitTween),
            child: exView,
          ),
          SlideTransition(
              position: animation.drive(tween),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 60,
                      spreadRadius: 1,
                      offset: Offset(-9, -9),
                      color: Color(0xffa3b1c6)),
                  BoxShadow(
                      blurRadius: 60,
                      spreadRadius: 1,
                      offset: Offset(9, 9),
                      color: Color(0xffa3b1c6))
                ]),
                child: view,
              ))
        ]);
      });
}
