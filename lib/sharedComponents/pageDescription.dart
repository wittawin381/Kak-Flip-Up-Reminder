import 'dart:math';

import 'package:demo/screenconfig/screen.dart';
import 'package:flutter/material.dart';
import 'photoview.dart';

class Description extends StatefulWidget {
  Description({this.images, this.descriptions});
  final List<String> images;
  final List<String> descriptions;

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  PageController pageController;
  int currentPage = 0;
  double page = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController(viewportFraction: 0.7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
              height: 400 * Screen.height,
              width: MediaQuery.of(context).size.width,
              child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      setState(() {
                        page = pageController.page;
                      });
                    }
                  },
                  child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: pageController,
                      itemCount: widget.images.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, position) {
                        final scale =
                            max(0.97, (-0.03 * (position - page).abs() + 1.0));
                        final opacity = (-0.5 * (position - page).abs() + 1.0);
                        return Opacity(
                            opacity: opacity,
                            child: Container(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Photoview(
                                                    image:
                                                        widget.images[position],
                                                    tag: 'picture$position',
                                                  )));
                                    },
                                    child: Hero(
                                      tag: 'picture$position',
                                      child: Container(
                                        // padding: EdgeInsets.all(20),
                                        clipBehavior: Clip.hardEdge,
                                        margin: EdgeInsets.all(20),
                                        height: 350 * Screen.height - 5,
                                        width: 300 * Screen.width,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.white
                                                    .withOpacity(0.8)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 20,
                                                  spreadRadius: -6,
                                                  offset: Offset(0, 5),
                                                  color: Color(0xff00ffa2)),
                                              // BoxShadow(
                                              //     blurRadius: 18,
                                              //     spreadRadius: 0,
                                              //     offset: Offset(0, 0),
                                              //     color: Color(0xffe8e8e8))
                                            ],
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    widget.images[position]),
                                                fit: BoxFit.contain)),

                                        // child: Image.asset(img),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }))),

          // .toList()))
          Container(
              width: MediaQuery.of(context).size.width - 60,
              // color: Colors.red,
              child: Text(
                widget.descriptions[currentPage],
                style: TextStyle(fontSize: 20 * Screen.scale),
              ))
        ]));
  }
}
