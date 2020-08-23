import 'package:audioplayers/audioplayers.dart';
import 'package:demo/excercises/components/playbutton.dart';
import 'package:demo/screenconfig/screen.dart';
import 'package:demo/sharedComponents/circleimage.dart';
import 'package:demo/sharedComponents/myAppBar.dart';
import 'package:demo/style.dart';
import 'package:flutter/material.dart';
import '../sharedComponents/pageDescription.dart';

class ExcerciseView extends StatefulWidget {
  ExcerciseView({this.data});
  final Map<String, dynamic> data;
  @override
  _ExcerciseViewState createState() => _ExcerciseViewState();
}

class _ExcerciseViewState extends State<ExcerciseView>
    with TickerProviderStateMixin {
  AnimationController pageSlideController;
  Animation pageSlideAnimation;
  AudioPlayer audioPlayer;
  GlobalKey<PlayButtonState> _keyChild1 = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    pageSlideController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    final Animation alarmCureve =
        CurvedAnimation(parent: pageSlideController, curve: Curves.ease);
    pageSlideAnimation =
        Tween<Offset>(begin: Offset(0, 0.08), end: Offset(0, 0))
            .animate(alarmCureve);
    pageSlideController.forward();
    audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageSlideController.dispose();
    // audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return WillPopScope(
        onWillPop: () {
          if (_keyChild1.currentState.audioPlayer != null) {
            _keyChild1.currentState.audioPlayer.stop();
          }
          Navigator.pop(context);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                MyAppBar(
                  title: widget.data['title'],
                  backButton: true,
                  onBackButtonPress: () {
                    pageSlideController.reverse();
                    if (_keyChild1.currentState.audioPlayer != null) {
                      _keyChild1.currentState.audioPlayer.stop();
                    }
                    // audioPlayer.stop();
                  },
                  size: "medium",
                  shadow: true,
                  rightItem: PlayButton(
                    key: _keyChild1,
                    sound: widget.data['sound'],
                    onPressed: () {},
                  ),
                ),
                SlideTransition(
                    position: pageSlideAnimation,
                    child: Container(
                        height: MediaQuery.of(context).size.height - 160,
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          physics: BouncingScrollPhysics(),
                          children: [
                            Column(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height -
                                        160 * Screen.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.all(0),
                                        children: [
                                          Container(
                                            // margin: EdgeInsets.only(top: 30),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Description(
                                                  descriptions:
                                                      widget.data['step'],
                                                  images: widget.data['images'],
                                                )
                                              ],
                                            ),
                                          )
                                        ]))
                              ],
                            )
                          ],
                        )))
              ],
            )));
  }
}
