import 'package:demo/Notification/notificationListView.dart';
import 'package:demo/about/about.dart';
import 'package:demo/excercises/excercisesListView.dart';
import 'package:demo/posture/postureListView.dart';
import 'package:demo/screenconfig/screen.dart';
import 'package:demo/sharedComponents/myAppBar.dart';
import 'package:demo/sharedComponents/myButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    Screen().init(context);
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
              height: MediaQuery.of(context).size.height - 250 * Screen.height,
              width: MediaQuery.of(context).size.width,
              child: SlideTransition(
                position: pageSlideAnimation,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: MainMenuButton(
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
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: MainMenuButton(
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
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
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
                            )),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: MainMenuButton(
                              image: FaIcon(
                                FontAwesomeIcons.info,
                                size: 50,
                                color: Color(0xffa0b1c4),
                              ),
                              title: "About us",
                              view: AboutView(),
                              onPressed: () {
                                pageSlideController.forward();
                              },
                            ))
                      ],
                    ),
                  ],
                ),
              ))
        ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
