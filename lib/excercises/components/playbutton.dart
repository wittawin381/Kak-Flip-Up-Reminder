import 'package:audioplayers/audioplayers.dart';
import 'package:demo/screenconfig/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../style.dart';

class PlayButton extends StatefulWidget {
  PlayButton({this.onPressed, this.sound});
  OnPlayPress onPressed;
  String sound;
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

typedef OnPlayPress = void Function();

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  AnimationController buttonController;
  AudioPlayer audioPlayer;
  AudioCache audioCache = AudioCache();
  Animation buttonZoomAnimation;
  bool playing = false;

  Future play() async {
    audioPlayer = await AudioCache().play('sound/' + widget.sound);
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        playing = !playing;
      });
    });
  }

  Future pause() async {
    audioPlayer.pause();
  }

  @override
  void initState() {
    // TODO: implement initState
    buttonController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    final curve = CurvedAnimation(parent: buttonController, curve: Curves.ease);
    buttonZoomAnimation = Tween<double>(begin: 0, end: 1).animate(curve);
    buttonController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return ScaleTransition(
        scale: buttonZoomAnimation,
        child: GestureDetector(
            onTap: () {
              if (playing) {
                pause();
              } else {
                widget.onPressed();
                play();
              }
              setState(() {
                playing = !playing;
              });

              // buttonController.reverse();
              // Navigator.pop(context);
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
                FontAwesomeIcons.volumeUp,
                color: playing ? Colors.green : Color(0xff222222),
                size: 30 * Screen.scale,
              ),
            )));
  }
}
