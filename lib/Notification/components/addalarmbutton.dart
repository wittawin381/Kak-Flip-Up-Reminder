import 'dart:math';

import 'package:demo/Notification/components/modal.dart';
import 'package:demo/screenconfig/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workmanager/workmanager.dart';
import 'package:path/path.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

typedef OnPressed = void Function();

class AddAlarmButton extends StatefulWidget {
  AddAlarmButton({this.controller, this.onPressed, this.value = false});
  bool value;
  AnimationController controller;
  OnPressed onPressed;
  @override
  _AddAlarmButtonState createState() => _AddAlarmButtonState();
}

class _AddAlarmButtonState extends State<AddAlarmButton>
    with TickerProviderStateMixin {
  Animation colorAnimation;
  Animation addIconAnimation;
  AnimationController addIconController;

  Future<List<Map<String, dynamic>>> getDB() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'notification.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE alarm(id INTEGER PRIMARY KEY, dateTime TEXT,autoalarm INTEGER, alarmcount INTEGER)",
        );
      },
      version: 1,
    );
    final List<Map<String, dynamic>> alarms = await db.query('alarm');
    if (alarms.length > 0) {
      // dbList = alarms;
      return alarms;
    }
    return null;
  }

  deleteDB() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'notification.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE alarm(id INTEGER PRIMARY KEY, dateTime TEXT, autoalarm INTEGER, alarmcount INTEGER)",
        );
      },
      version: 1,
    );
    await db.delete('alarm', where: "id = 1");
  }

  void setAlarmEnabledValue() {
    getDB().then((value) {
      if (value != null) {
        setState(() {
          widget.value = true;
        });
      } else {
        setState(() {
          widget.value = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // addIconController =
    //     AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    setAlarmEnabledValue();
    addIconController = widget.controller;
    final Animation addAnimationCurve =
        CurvedAnimation(parent: addIconController, curve: Curves.ease);
    addIconAnimation =
        Tween<double>(begin: 0, end: pi / 4).animate(addAnimationCurve);
    colorAnimation =
        ColorTween(begin: Color(0xff14b1ab), end: Color(0xffe8505b))
            .animate(addAnimationCurve);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 80 * Screen.height,
      duration: Duration(milliseconds: 200),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.easeInOutSine,
      // color: Colors.red,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
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
          ]),
      margin:
          EdgeInsets.only(left: 20 * Screen.scale, right: 20 * Screen.scale),
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80 * Screen.width,
              height: 300 * Screen.height,
            ),
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.red,
                height: 80 * Screen.height,
                alignment: Alignment.center,
                child: Text(
                  'การแจ้งเตือน',
                  style: TextStyle(fontSize: 25 * Screen.scale),
                ),
              ),
            ),
            SizedBox(
                width: 80 * Screen.scale,
                height: 80 * Screen.scale,
                child: Switch(
                  activeColor: Colors.green,
                  value: widget.value,
                  onChanged: (active) {
                    widget.onPressed();
                  },
                ))
          ],
        ),
      ]),
    );
  }
}
