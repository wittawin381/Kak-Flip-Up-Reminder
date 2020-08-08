import 'package:demo/main.dart';
import 'package:demo/screenconfig/screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../style.dart';

typedef OnBackButtonPress = void Function();

class MyAppBar extends StatefulWidget {
  MyAppBar(
      {this.title,
      this.backButton = false,
      this.onBackButtonPress,
      this.size,
      this.rightItem,
      this.shadow = false});
  final String title;
  final bool backButton;
  final String size;
  final dynamic rightItem;
  final bool shadow;
  OnBackButtonPress onBackButtonPress;
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> with TickerProviderStateMixin {
  AnimationController backbuttonController;
  Animation backbuttonZoomAnimation;
  AnimationController titleController;
  Animation titleAnimation;
  double fontsize = 0;

  void initFontSize() {
    Screen().init(context);
    if (widget.size == 'medium') {
      fontsize = 30 * Screen.scale;
    } else if (widget.size == 'small') {
      fontsize = 25 * Screen.scale;
    } else {
      fontsize = 50 * Screen.scale;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    backbuttonController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    final curve =
        CurvedAnimation(parent: backbuttonController, curve: Curves.ease);
    backbuttonZoomAnimation = Tween<double>(begin: 0, end: 1).animate(curve);

    titleController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    final curve2 = CurvedAnimation(parent: titleController, curve: Curves.ease);
    titleAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(curve2);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    backbuttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    backbuttonController.forward();
    Screen().init(context);
    initFontSize();
    // titleController.forward();
    return Container(
        // color: Colors.red,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: (widget.shadow
                ? [
                    BoxShadow(
                        blurRadius: 20,
                        spreadRadius: -10,
                        offset: Offset(0, -2),
                        color: Colors.black),
                  ]
                : [])),
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100 * Screen.scale,
                    child: widget.backButton
                        ? ScaleTransition(
                            scale: backbuttonZoomAnimation,
                            child: GestureDetector(
                                onTap: () {
                                  backbuttonController.reverse();
                                  Navigator.pop(context);
                                  widget.onBackButtonPress();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  // color: Colors.red,
                                  margin: EdgeInsets.all(20),

                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                            color: MyStyle.darkSharow),
                                        BoxShadow(
                                            offset: Offset(-2, -2),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                            color: Colors.white),
                                      ]),

                                  child: FaIcon(
                                    FontAwesomeIcons.chevronLeft,
                                    color: Color(0xff222222),
                                    size: 30 * Screen.scale,
                                  ),
                                )))
                        : Container()),
                Expanded(
                  flex: 8,
                  child: SlideTransition(
                    position: titleAnimation,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff222222),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Chonburi',
                            fontSize: fontsize),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100 * Screen.scale,
                  child: widget.rightItem,
                ),
              ],
            )));
  }
}

// PreferredSize MyAppBar(String title) {
//   return PreferredSize(
//       preferredSize: Size.fromHeight(100),
//       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         AppBar(
//           centerTitle: true,
//           title: Text(title),
//           backgroundColor: Color(0xffe0e5ec),
//           shadowColor: Color(0xffA3B1C6),
//           elevation: 0,
//         ),
//       ]));
// }
