import 'package:demo/sharedComponents/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> with TickerProviderStateMixin {
  AnimationController pageSlideController;
  Animation pageSlideAnimation;

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
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageSlideController.dispose();
    super.dispose();
  }

  _launchURL() async {
    const url =
        'http://phn.bangkok.go.th/file_book/%E0%B8%84%E0%B8%B9%E0%B9%88%E0%B8%A1%E0%B8%B7%E0%B8%AD%E0%B8%9C%E0%B8%B9%E0%B9%89%E0%B8%94%E0%B8%B9%E0%B9%81%E0%B8%A5%E0%B8%9C%E0%B8%B9%E0%B9%89%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B9%84%E0%B8%A1%E0%B9%88%E0%B8%AA%E0%B8%B2%E0%B8%A1%E0%B8%B2%E0%B8%A3%E0%B8%96%E0%B8%94%E0%B8%B9%E0%B9%81%E0%B8%A5%E0%B8%AA%E0%B8%B8%E0%B8%82%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B8%9E%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%90%E0%B8%B2%E0%B8%99%E0%B8%94%E0%B9%89%E0%B8%A7%E0%B8%A2%E0%B8%95%E0%B8%99%E0%B9%80%E0%B8%AD%E0%B8%87%E0%B9%84%E0%B8%94%E0%B9%89.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<String> maker = [
    "1.นส.นันท์นภัส  ฮุงหวน",
    "2.นส.นันทิกานต์ ฟักสิทธิ์",
    "3.นส.น้ำฝน    ปฏิเส",
    "4.นส.นิชดา    วงษ์เวียงจันทร์",
    "5.นส.นิตยา     เทพา",
    "6.นส.นิธินาถ   โยชนะ",
    "7.นส.ปฏิมาภรณ์  ดาวกระจ่าง",
    "8.นส.ปภัสรา    ศรีสุวรรณ",
    "9.นส.ปภาดา    บุญยืน",
    "10.นส.ปภาพินท์   บุญยืน",
    "11.นส.ประภัสรา   แตงทอง",
    "12.นส.ปรางมาศ  เขียวขำ",
    "13.นส.ปวรา   เจือจันทร์",
    "14.นส.ปวันรัตน์  เทียนขวัญ",
    "15.นส.ปองกมล   สุขพรหม"
  ];
  people() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          MyAppBar(
            title: 'About',
            backButton: true,
            onBackButtonPress: () {
              pageSlideController.reverse();
            },
            size: "medium",
          ),
          SlideTransition(
              position: pageSlideAnimation,
              child: Container(
                  padding: EdgeInsets.only(left: 40),
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                          Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              child: GestureDetector(
                                child: Text(
                                  "Reference Book",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () {
                                  _launchURL();
                                },
                              )),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: Text("รายชื่อผู้จัดทำ"),
                          ),
                        ] +
                        maker
                            .map((name) => Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 5, bottom: 5),
                                  child: Text(name),
                                ))
                            .toList() +
                        [
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: Text("Email: tete.wittawin@gmail.com"),
                          )
                        ],
                  )))
        ]));
  }
}
