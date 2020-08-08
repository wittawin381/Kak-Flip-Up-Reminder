import 'package:demo/Notification/notificatoinView.dart';
import 'package:demo/screenconfig/screen.dart';
import 'package:demo/sharedComponents/myButton.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

typedef OnCheckPress = void Function();
typedef OnClearPress = void Function();

class ShowModal extends StatefulWidget {
  ShowModal({this.key, this.onCheckPressed, this.onClearPress});
  GlobalKey<ScaffoldState> key;
  OnCheckPress onCheckPressed;
  OnClearPress onClearPress;
  @override
  _ShowModalState createState() => _ShowModalState();
}

class _ShowModalState extends State<ShowModal> {
  final snackBar = SnackBar(
    content: Text('ตังเวลาสำเร็จ'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffe0e5ec),
        height: 450,
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            height: 80 * Screen.height,
            child: Text(
              "กรุณาเลือกเวลา",
              style: TextStyle(fontSize: 30 * Screen.scale),
            ),
          ),
          Container(
            color: Color(0xffe0e5ec),
            child: NotificationItem(
              onCheckPress: () {
                // widget.key.currentState.showSnackBar(snackBar);
                print("check");
                // open();
                // alarmEnabled = true;
                Workmanager.cancelAll();
                widget.onCheckPressed();
                // getDB().then((value) {
                //   print('auto delete db set');
                //   // print(DateTime.now().);
                //   sendNotification(
                //       int.parse(value[0]['dateTime']), value[0]['autoalarm']);
                //   int now = DateTime.now().millisecondsSinceEpoch;
                //   int defaultval = DateTime.fromMillisecondsSinceEpoch(
                //           int.parse(value[0]['dateTime']))
                //       .millisecondsSinceEpoch;

                //   // int diff = now - defaultval;

                //   int diff = DateTime.fromMillisecondsSinceEpoch(
                //           int.parse(value[0]['dateTime']))
                //       .difference(DateTime.now())
                //       .inMilliseconds;

                //   // while (diff > 60000 * 60 * value[0]['autoalarm']) {
                //   //   diff -= (60000 * 60 * value[0]['autoalarm']);
                //   // }
                //   // diff = (60000 * 60 * value[0]['autoalarm']) - diff;
                //   for (int i = 0; i < 6; i++) {
                //     int hour = diff + value[0]['autoalarm'] * 60 * 60000 * i;
                //     print("diff : " +
                //         diff.toString() +
                //         " hour" +
                //         hour.toString());
                //     if (i == 0) {
                //       Workmanager.registerOneOffTask(i.toString(),
                //           "update", //This is the value that will be returned in the callbackDispatcher
                //           // frequency: Duration(hours: value[0]['autoalarm']),
                //           initialDelay: Duration(milliseconds: diff));
                //     } else {
                //       Workmanager.registerOneOffTask(i.toString(),
                //           "update", //This is the value that will be returned in the callbackDispatcher
                //           // frequency: Duration(hours: value[0]['autoalarm']),
                //           initialDelay: Duration(milliseconds: hour));
                //     }
                //   }

                //   Workmanager.registerOneOffTask("3",
                //       "update", //This is the value that will be returned in the callbackDispatcher
                //       // frequency: Duration(hours: value[0]['autoalarm']),
                //       initialDelay: Duration(minutes: 2));
                // });

                // if (_timer != null) {
                //   if (_timer.isActive) {
                //     _timer.cancel();
                //   }
                // }
                // // generateList();
                // setAlarm();
                // generateList();
                // setState(() {});
                // addIconController.forward(); // setAlarmController.forward();

                // // generateList();
                // // alarmtitleSlideController.forward();
                // alarmtitle = 'การแจ้งเตือนของคุณ';
                // setState(() {
                //   Navigator.pop(context);
                // });
              },
              onClearPress: () {
                widget.onClearPress();
                print("clear");
                // printPendingNotification();
                // setState(() {
                //   Navigator.pop(context);
                // });
              },
            ),
          )
        ]));
  }
}
