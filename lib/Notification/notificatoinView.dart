import 'package:demo/Notification/components/circlebutton.dart';
import 'package:demo/screenconfig/screen.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'alarmModel.dart';
import '../sharedComponents/myAppBar.dart';

typedef OnClearPress = void Function();
typedef OnCheckPress = void Function();

class NotificationItem extends StatefulWidget {
  NotificationItem({this.onCheckPress, this.onClearPress});
  OnClearPress onClearPress;
  OnCheckPress onCheckPress;
  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  DateTime time = DateTime.now();
  int hour = 0;
  int minute = 0;
  int automaticAlarm = 0;

  @override
  initState() {
    this.hour = time.hour;
    this.minute = time.minute;
  }

  Future<List<Map<String, dynamic>>> printDB() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'notification.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE alarm(id INTEGER PRIMARY KEY, dateTime TEXT, autoalarm INTEGER)",
        );
      },
      version: 1,
    );
    final List<Map<String, dynamic>> alarms = await db.query('alarm');
    return alarms;
  }

  Future<int> addAlarm() async {
    int day = DateTime.now().day;
    if (DateTime.now().hour >= hour && DateTime.now().minute >= minute) {
      day += 1;
    }

    // String newDate =
    //     hour.toString() + ':' + (minute > 9 ? '' : '0') + minute.toString();
    String newDate =
        (DateTime(DateTime.now().year, DateTime.now().month, day, hour, minute)
                .millisecondsSinceEpoch)
            .toString();
    print(DateTime.fromMillisecondsSinceEpoch(int.parse(newDate)));
    Map<String, dynamic> newAlarm = {
      'id': 1,
      'dateTime': newDate,
      'autoalarm': 2,
      'alarmcount': 12
    };
    final db = await openDatabase(
      join(await getDatabasesPath(), 'notification.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE alarm(id INTEGER PRIMARY KEY, dateTime TEXT, autoalarm INTEGER, alarmcount INTEGER)",
        );
      },
      version: 1,
    );

    await db.insert(
      'alarm',
      newAlarm,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // await db.execute("DROP TABLE alarm");
    // await db.delete('alarm', where: "id = 1");

    // print(await printDB());
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return Column(children: [
      // MyAppBar(
      //   title: "Alarm",
      //   backButton: true,
      // ),
      Container(
          child: Column(
        children: [
          Container(
            width: 350 * Screen.width,
            height: 200 * Screen.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              NumberPicker.integer(
                initialValue: hour,
                infiniteLoop: true,
                minValue: 0,
                maxValue: 23,
                onChanged: (newValue) => setState(() => {hour = newValue}),
              ),
              NumberPicker.integer(
                initialValue: minute,
                infiniteLoop: true,
                minValue: 0,
                maxValue: 59,
                onChanged: (newValue) => setState(() => {minute = newValue}),
              ),
            ]),
          ),
          Container(
              margin: EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleButton(
                onPressed: () {
                  // print("ckhe");
                  widget.onClearPress();
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: 40 * Screen.scale,
                ),
              ),
              CircleButton(
                onPressed: () {
                  addAlarm();

                  widget.onCheckPress();
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 40 * Screen.scale,
                ),
              )
            ],
          )
        ],
      ))
    ]);
  }
}
