import 'package:demo/Notification/alarmList.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  ItemList({this.item, this.animation, this.index});
  final String item;
  final Animation animation;
  final int index;
  @override
  Widget build(BuildContext context) {
    // print(item);
    return SizeTransition(
        sizeFactor: animation,
        child: Container(
            // margin: EdgeInsets.only(bottom: 10),
            child: AlarmList(
          time: item,
          active: index == 0,
        )));
  }
}
