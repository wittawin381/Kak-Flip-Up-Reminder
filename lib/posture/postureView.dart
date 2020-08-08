import 'package:demo/screenconfig/screen.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../sharedComponents/circleimage.dart';
import '../sharedComponents/myAppBar.dart';
import 'package:demo/style.dart';
import '../sharedComponents/pageDescription.dart';

class PostureView extends StatefulWidget {
  PostureView({this.title = "", this.tag, this.data});
  final String title;
  final int tag;
  final Map<String, dynamic> data;
  @override
  _PostureViewState createState() => _PostureViewState();
}

class _PostureViewState extends State<PostureView>
    with TickerProviderStateMixin {
  AnimationController pageSlideController;
  Animation pageSlideAnimation;
  ScrollController scrollController;

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
    scrollController = ScrollController();
    pageSlideController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          MyAppBar(
            title: widget.title,
            size: "medium",
            backButton: true,
            onBackButtonPress: () {
              pageSlideController.reverse();
            },
            shadow: true,
          ),
          SlideTransition(
              position: pageSlideAnimation,
              child: Container(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      children: [
                        Container(
                          // margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Hero(
                              //   tag: widget.tag,
                              //   child: CircleImage(
                              //     image: widget.data['image'],
                              //     height: 200,
                              //     width: 200,
                              //   ),
                              // ),
                              Description(
                                descriptions: widget.data['step'],
                                images: widget.data['images'],
                              )
                            ],
                          ),
                        )
                      ])))
        ]));
  }
}
