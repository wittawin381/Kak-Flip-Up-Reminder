import 'dart:async';
import 'package:demo/Notification/components/addalarmbutton.dart';
import 'package:demo/Notification/components/modal.dart';
import 'package:demo/Notification/itemlist.dart';
import 'package:demo/screenconfig/screen.dart';
import 'package:demo/sharedComponents/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationListView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: MyAppBar("Some APP"),
        backgroundColor: Color(0xffe0e5ec),
        body: Container(child: MyNotification()));
  }
}

class MyNotification extends StatefulWidget {
  @override
  _MyNotificationState createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification>
    with TickerProviderStateMixin {
////
  String message;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";

  sendNotification(int time, int next) async {
    for (int i = 0; i <= 5; i++) {
      var scheduledNotificationDateTime =
          DateTime.fromMillisecondsSinceEpoch(time + (60000 * 60 * next * i));

      var androidPlatformChannelSpecifics = AndroidNotificationDetails('10000',
          'FLUTTER_NOTIFICATION_CHANNEL', 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
          importance: Importance.Max, priority: Priority.High);
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.schedule(
          i,
          'ได้เวลาพลิกตัวแล้ว!',
          'ถึงเวลาแล้ว มาพลิกตัวกันเถอะ',
          scheduledNotificationDateTime,
          platformChannelSpecifics,
          payload: 'I just haven\'t Met You Yet');
    }
  }

  ///
  double _height;
  double _width = 80;
  bool alarmEnabled = false;
  AnimationController controller;
  AnimationController opacityController;
  Animation slideAnimation;
  Animation opacityAnimation;
  Animation scaleAnimation;
  Animation alarmtitleSlideAnimation;
  Animation alarmtitleFadeAnimation;

  // Animation colorAnimation;
  // Animation addIconAnimation;
  AnimationController addIconController;

  AnimationController alarmtitleSlideController;
  AnimationController alarmtitleFadeController;

  AnimationController alarmController;
  Animation alarmAnimation;

  AnimationController setAlarmController;
  Animation setAlarmAnimation;

  List<String> alarmList = [];
  int size;
  List<Map<String, dynamic>> dbList = [];
  StreamController<List<Map<String, dynamic>>> dbStream;

  List<String> demolist = ['a', 'b', 'c', 'd'];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  Timer _timer;

  void setAlarm() {
    getDB().then((value) {
      if (_timer != null) {
        if (_timer.isActive) {
          _timer.cancel();
        }
      }

      int diff =
          (DateTime.fromMillisecondsSinceEpoch(int.parse(value[0]['dateTime']))
              .difference(DateTime.now())
              .inMilliseconds);

      // int diff = now - defaultval;
      if (diff < 0) {
        diff = diff.abs();
        while (diff > 60000 * 60 * value[0]['autoalarm']) {
          diff -= (60000 * 60 * value[0]['autoalarm']);
        }
        diff = (60000 * 60 * value[0]['autoalarm']) - diff;
      }

      _timer = Timer.periodic(Duration(milliseconds: diff), (time) {
        if (value[0]['alarmcount'] == 1) {
          return;
        } else {
          onDelete(0);
          setAlarm();
        }
      });
    });
  }

  @override
  initState() {
    int time = 0;
    // _timer = new Timer.periodic(Duration(minutes: DateTime.now().difference(DateTime())), (timer) { })
    _height = 80;
    // dbStream = StreamController<List<Map<String, dynamic>>>();
    getDB().then((value) {
      if (value != null) {
        setAlarm();
        alarmEnabled = true;
        // addIconController.forward();
      }
    });
    generateList();

    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    opacityController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    alarmController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    setAlarmController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    alarmtitleSlideController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    addIconController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutSine);
    final Animation opacityCurve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    final Animation alarmCureve =
        CurvedAnimation(parent: alarmController, curve: Curves.ease);
    final Animation setAlarmCurve =
        CurvedAnimation(parent: setAlarmController, curve: Curves.ease);
    final Animation alarmtitleCurve =
        CurvedAnimation(parent: alarmtitleSlideController, curve: Curves.ease);

    slideAnimation =
        Tween(begin: Offset(0, -0.15), end: Offset(0, 0)).animate(curve);
    opacityAnimation = Tween<double>(begin: 0.0, end: 1).animate(opacityCurve);
    scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(curve);
    alarmAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
        .animate(alarmCureve);
    setAlarmAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1))
        .animate(setAlarmCurve);
    alarmtitleSlideAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
            .animate(alarmtitleCurve);
    alarmtitleFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(alarmtitleCurve);
    message = "No message.";

    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {});
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
      // when user tap on notification.
      setState(() {
        message = payload;
      });
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    if (_timer != null) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
    controller.dispose();
    opacityController.dispose();
    alarmController.dispose();
    setAlarmController.dispose();
    // alarmtitleFadeController.dispose();
    alarmtitleSlideController.dispose();
    addIconController.dispose();
  }

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
      dbList = alarms;
      return alarms;
    }
    return null;
  }

  delteDB() async {
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
    // await db.execute("DROP TABLE alarm");
  }

  updateDB() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'notification.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE alarm(id INTEGER PRIMARY KEY, dateTime TEXT, autoalarm INTEGER, alarmcount INTEGER)",
        );
      },
      version: 1,
    );
    Map<String, dynamic> alarm = Map.from((await db.query('alarm'))[0]);
    alarm['alarmcount'] -= 1;
    setState(() {
      size = alarm['alarmcount'];
    });
    if ((alarm['alarmcount']) > 0) {
      // await db.update('alarm', alarm,
      //     // Ensure that the Dog has a matching id.
      //     where: "id = ?",
      //     whereArgs: [alarm['id']]);
      // dbStream.add([alarm]);
    } else {
      await db.delete('alarm', where: "id = 1");
    }

    // await db.execute("DROP TABLE alarm");
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

  void onDelete(int index) {
    try {
      String removeItem = alarmList.removeAt(0);
      AnimatedListRemovedItemBuilder builder = (context, animation) {
        return ItemList(item: removeItem, animation: animation, index: index);
      };
      _listKey.currentState.removeItem(0, builder);
      updateDB();
    } catch (e) {
      print("Crashed");
    }
  }

  void generateList() {
    alarmList = [];
    getDB().then((value) {
      int time;
      if (value != null) {
        size = value[0]['alarmcount'];
        // alarmList = [];
        for (int i = 0; i < size; i++) {
          time = int.parse(value[0]['dateTime']) +
              60000 * 60 * (value[0]['autoalarm'] * (6 - size + i));
          String eachDate = DateTime.fromMillisecondsSinceEpoch(time)
              .toString()
              .substring(0, 10);
          String alarmListString =
              (DateTime.fromMillisecondsSinceEpoch(time).hour <= 9 ? '0' : '') +
                  DateTime.fromMillisecondsSinceEpoch(time).hour.toString() +
                  ":" +
                  (DateTime.fromMillisecondsSinceEpoch(time).minute <= 9
                      ? '0'
                      : '') +
                  DateTime.fromMillisecondsSinceEpoch(time).minute.toString();
          alarmListString = alarmListString + ' $eachDate';
          alarmList.add(alarmListString);
        }
      }
    });
  }

  printPendingNotification() async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print(pendingNotificationRequests.length);
    return pendingNotificationRequests.length;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final snackBar = SnackBar(
    content: Text('ตังเวลาสำเร็จ'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  void setBackGroundTask() {
    Workmanager.cancelAll();
    getDB().then((value) {
      // print(DateTime.now().);
      sendNotification(int.parse(value[0]['dateTime']), value[0]['autoalarm']);

      int diff =
          DateTime.fromMillisecondsSinceEpoch(int.parse(value[0]['dateTime']))
              .difference(DateTime.now())
              .inMilliseconds;
      for (int i = 0; i < 12; i++) {
        int hour = diff + value[0]['autoalarm'] * 60 * 60000 * i;
        // print("diff : " + diff.toString() + " hour" + hour.toString());
        if (i == 0) {
          Workmanager.registerOneOffTask(i.toString(),
              "update", //This is the value that will be returned in the callbackDispatcher
              // frequency: Duration(hours: value[0]['autoalarm']),
              initialDelay: Duration(milliseconds: diff));
        } else {
          Workmanager.registerOneOffTask(i.toString(),
              "update", //This is the value that will be returned in the callbackDispatcher
              // frequency: Duration(hours: value[0]['autoalarm']),
              initialDelay: Duration(milliseconds: hour));
        }
      }

      // Workmanager.registerOneOffTask("3",
      //     "update", //This is the value that will be returned in the callbackDispatcher
      //     // frequency: Duration(hours: value[0]['autoalarm']),
      //     initialDelay: Duration(minutes: 2));
    });
  }

  void resetTimer() {
    if (_timer != null) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ShowModal(
            onCheckPressed: () {
              _scaffoldKey.currentState.showSnackBar(snackBar);
              setBackGroundTask();
              resetTimer();
              // generateList();
              setAlarm();
              generateList();
              setState(() {});
              addIconController.forward(); // setAlarmController.forward();

              setState(() {
                Navigator.pop(context);
              });
            },
            onClearPress: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    alarmController.forward();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Wrap(children: [
          MyAppBar(
            title: "Alarm",
            backButton: true,
            onBackButtonPress: () {
              alarmController.reverse();
            },
          ),
          SlideTransition(
              position: alarmAnimation,
              child: Wrap(children: <Widget>[
                AddAlarmButton(
                  value: alarmEnabled,
                  controller: addIconController,
                  onPressed: () {
                    getDB().then((value) {
                      if (value == null) {
                        alarmEnabled = true;
                        showModal(context);
                        // print(await getDB());
                      } else {
                        alarmEnabled = false;
                        Workmanager.cancelAll();
                        deleteDB();
                        flutterLocalNotificationsPlugin.cancelAll();
                        addIconController.reverse();
                        setState(() {});
                      }
                    });
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height -
                      (280 * Screen.height),
                  margin: EdgeInsets.all(20 * Screen.scale),
                  child: FutureBuilder(
                      future: getDB(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && alarmList.length > 0) {
                          // print(snapshot.data[0]['alarmcount']);
                          return AnimatedList(
                            key: _listKey,
                            initialItemCount: alarmList.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index, animation) {
                              // print(index);
                              return ItemList(
                                  item: alarmList[index],
                                  animation: animation,
                                  index: index);
                            },
                          );
                        }
                        return Container();
                      }),
                )
              ] ////this one
                  ))
        ]));
  }
}
