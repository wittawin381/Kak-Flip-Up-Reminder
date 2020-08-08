import 'package:demo/screenconfig/screen.dart';
import 'package:flutter/material.dart';

class AlarmList extends StatefulWidget {
  AlarmList({this.time, this.active = false});
  final String time;
  final bool active;
  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    List<String> date = widget.time.split(' ');
    return Container(
        padding:
            EdgeInsets.only(left: 30 * Screen.scale, right: 30 * Screen.scale),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  spreadRadius: -10,
                  offset: Offset(5, 5),
                  color: Color(0xffa3b1c6)),
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: Offset(-1, -1),
                  color: Color(0xffe8e8e8))
            ],
            border: Border(
                top:
                    BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Container(
                // margin: EdgeInsets.only(right: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: []),
                // margin: EdgeInsets.only(left: 20, right: 20),
                height: 120 * Screen.scale,
                // width: MediaQuery.of(context).size.width - 100,
                alignment: Alignment.center,
                // width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  date[0],
                  style: TextStyle(
                      fontSize: 40 * Screen.scale, fontWeight: FontWeight.bold),
                )),
            Container(
                child: Text(
              date[1],
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ))
          ],
        ));
  }
}
