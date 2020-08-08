import 'package:demo/Notification/notificationListView.dart';
import 'package:demo/excercises/excercisesListView.dart';
import 'package:demo/posture/postureListView.dart';
import 'package:demo/sharedComponents/myAppBar.dart';
import 'package:demo/sharedComponents/myButton.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController pageSlideController;
  Animation pageSlideAnimation;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    pageSlideController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    final curve =
        CurvedAnimation(parent: pageSlideController, curve: Curves.ease);
    pageSlideAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.08))
            .animate(curve);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageSlideController.reverse();
    return Scaffold(
      // appBar: MyAppBar("Some APP"),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(children: [
          MyAppBar(
            title: "Flip Up Reminder",
            size: 'medium',
          ),
          Container(
              margin: EdgeInsets.only(top: 40),
              child: SlideTransition(
                position: pageSlideAnimation,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MainMenuButton(
                          image: Icon(
                            Icons.alarm,
                            size: 100,
                            color: Color(0xffA3B1C6),
                          ),
                          title: "การแจ้งเตือน",
                          view: NotificationListView(),
                          onPressed: () {
                            pageSlideController.forward();
                          },
                        ),
                        MainMenuButton(
                          image: Image.asset(
                            'assets/postures/posture.png',
                            height: 100,
                            width: 100,
                          ),
                          title: "ท่าพลิกตะแคงผู้ป่วย",
                          view: PostureListView(),
                          onPressed: () {
                            pageSlideController.forward();
                          },
                        )
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.all(50),
                        child: MainMenuButton(
                          image: Image.asset(
                            'assets/excercises/excercise.png',
                            height: 100,
                            width: 100,
                          ),
                          title: "การบริหารท่าผู้ป่วย",
                          view: ExcercisesListView(),
                          onPressed: () {
                            pageSlideController.forward();
                          },
                        ))
                  ],
                ),
              ))
        ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
