import 'package:demo/main/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workmanager/workmanager.dart';
import 'Notification/notificationListView.dart';
import 'excercises/excercisesListView.dart';
import 'posture/postureListView.dart';
import 'sharedComponents/myAppBar.dart';
import 'sharedComponents/myButton.dart';
import 'dart:async';
import 'package:path/path.dart';

void callbackDispatcher() {
  Workmanager.executeTask((task, cmd) async {
    try {
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
      // alarm['dateTime'] = DateTime.now().millisecondsSinceEpoch.toString();

      if ((alarm['alarmcount']) > 0) {
        await db.update('alarm', alarm,
            // Ensure that the Dog has a matching id.
            where: "id = ?",
            whereArgs: [alarm['id']]);
      } else {
        await db.delete('alarm', where: "id = 1");
        Workmanager.cancelAll();
      }
    } catch (e) {
      print("Crashed in main");
    }

    //Return true when the task executed successfully or not
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager.initialize(callbackDispatcher, isInDebugMode: false);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // is not restarted.
          fontFamily: 'Krub',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Color(0xff222222), fontSize: 50, fontFamily: 'Krub'))),
      home: MyHomePage(title: 'Some App eiei'),
    );
  }
}
