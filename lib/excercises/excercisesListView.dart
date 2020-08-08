import 'package:demo/screenconfig/screen.dart';
import 'package:demo/sharedComponents/circleimage.dart';
import 'package:demo/sharedComponents/customMaterialRoute.dart';
import 'package:demo/sharedComponents/myAppBar.dart';
import 'package:flutter/material.dart';
import '../style.dart';
import 'excerciseView.dart';

class ExcercisesListView extends StatefulWidget {
  @override
  _ExcercisesListViewState createState() => _ExcercisesListViewState();
}

class _ExcercisesListViewState extends State<ExcercisesListView>
    with TickerProviderStateMixin {
  AnimationController pageSlideController;
  Animation pageSlideAnimation;

  @override
  initState() {
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

  List<Map<String, dynamic>> menu = [
    {
      'title': 'ท่าบริหารข้อไหล่',
      'image': 'assets/excercises/shoulder.png',
      'view': null,
      'images': [
        'assets/excercises/shoulder/image1.png',
        'assets/excercises/shoulder/image2.png',
      ],
      'step': [
        'ท่าที่ 1 ยกแขนตรงเหยียดข้อศอกขึ้นช้าๆ เหยียดจนสุดแล้ววางลงช้าๆ (ทําซ้ํา 5 คร้ัง)',
        'ท่าที่ 2 กางแขนผู้ป่วยออก 90 องศา ยกขึ้นช้าๆ จนสุด (ทําซ้ํา 5 ครั้ง)'
      ],
      'sound': 'enemy-spotted.mp3',
    },
    {
      'title': 'ท่าบริหารข้อศอก',
      'image': 'assets/excercises/elbow.png',
      'view': null,
      'images': [
        'assets/excercises/elbow/image1.png',
      ],
      'step': [
        'ท่าที่ 1 เหยียดแขนงอศอกขึ้น-ลงช้าๆ (ทําซ้ํา 5 ครั้ง) ในท่าเหยียดแขนตรง \n\nท่าที่ 2 กางแขนผู้ป่วยออกงอข้อศอกตั้งฉาก แล้วหมุนลงช้าๆ ระวังข้อไหล่หลุดในผู้ท่ีเคย ข้อไหล่หลุด จากนั้นกลับมาทําท่าเดิม งอข้อศอกตั้งฉากแล้วหมุนขึ้น (ทําซ้ํา 5 คร้ัง)'
      ],
      'sound': null,
    },
    {
      'title': 'ท่าบริหารข้อมือ',
      'image': 'assets/excercises/wrist.png',
      'view': null,
      'images': [
        'assets/excercises/wrist/image1.png',
      ],
      'step': [
        'ท่าที่ 1 กระดกข้อมือขึ้นเหยียดนิ้วมือตรง ท้ัง 4 นิ้ว \n\nท่าที่ 2 กระดกข้อมือลง \n\nท่าที่ 3 เอียงข้อมือไปทางซ้ายและขวา'
      ],
      'sound': null,
    },
    {
      'title': 'ท่าบริหารนิ้วมือ',
      'image': 'assets/excercises/finger.png',
      'view': null,
      'images': [
        'assets/excercises/finger/image1.png',
        'assets/excercises/finger/image2.png',
      ],
      'step': [
        'ท่าที่ 1 กํานิ้วผู้ป่วยให้กระชับ นิ้วโป้ง เหยียดตรงนาบไปกับนิ้วด้านฝ่ามือ และนิ้ว ชี้ งอกระชับ นิ้วผู้ป่วย และดึง นิ้วผู้ป่วย เหยียดตรง ดึงออกช้าๆ ให้รู้สึกมีการขยับ ข้อในแนวระนาบแล้วหมุน เบาๆ แล้วปล่อย \n\nท่าที่ 2 งอนิ้วแต่ละนิ้วลงแล้วค่อยๆ เหยียดออก \n\nท่าที่ 3 ขยับข้อต่อนิ้ว ขึ้น-ลง ทุกข้อ เริ่มจากพับมือลง งอนิ้วมือเข้าหาฝ่ามือ จากนั้น เอามือโอบหลังมือ ผู้ป่วยค่อยๆ ดันลงมา ให้ผู้ป่วยกํามือลง',
        'ท่าท่ี 4 บริหารนิ้วโป้งโดยการจับน้ิวโป้ง ส่วนปลายแล้วค่อยๆ กางออกช้าๆ จนสุด แล้วกลับมาท่าเดิมทําซ้ํา'
      ],
      'sound': null,
    },
    {
      'title': 'ท่าบริหารข้อสะโพก-ข้อเข่า',
      'image': 'assets/excercises/hips.png',
      'view': null,
      'images': [
        'assets/excercises/hips/image1.png',
        'assets/excercises/hips/image2.png',
      ],
      'step': [
        'ท่าที่ 1 งอสะโพก งอเข่าแล้วค่อยๆ เหยียดขาตรง (รูปที่ 15) \n\nท่าที่ 2 กลับมาท่างอสะโพก ตั้งฉาก งอเข่า ต้ังฉาก หมุนปลายเท้าออกนอก และเข้าในช้าๆ(รูปที่16)',
        'ท่าที่ 3 เหยียดขาผู้ป่วยตรง มือประคอง ที่หลังส้นเท้าและต้นขาค่อยๆ กางขาผู้ป่วย ออกและหุบเข้าช้าๆ'
      ],
      'sound': null,
    },
    {
      'title': 'การบริหารข้อเท้า',
      'image': 'assets/excercises/ankle.png',
      'view': null,
      'images': [
        'assets/excercises/ankle/image1.png',
      ],
      'step': [
        'ท่าที่ 1 มือจับเหนือข้อเท้าอีกมือประคอง ใต้ส้นเท้า ให้ท้องแขนชิดกับฝ่าเท้าเพื่อเป็น การประคอง ดันฝ่าเท้ากระดกขึ้นช้าๆ (ทําซ้ํา 5 คร้ัง) \n\n ท่าที่ 2 มือจับหลังเท้า และส้นเท้ากระดก ข้อเท้าข้ึนลง (ทําซ้ํา 5 คร้ัง) \n\n ท่าที่ 3 มือจับหลังเท้า และเหนือข้อเท้า บิดเท้าเข้าใน ออกนอก'
      ],
      'sound': null,
    }
  ];

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            MyAppBar(
              title: "การบริหารข้อและกล้ามเนื้อ",
              backButton: true,
              onBackButtonPress: () {
                pageSlideController.reverse();
              },
              size: "small",
            ),
            SlideTransition(
                position: pageSlideAnimation,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView(
                        padding: EdgeInsets.only(
                            top: 0,
                            left: 40 * Screen.scale,
                            right: 20 * Screen.scale,
                            bottom: 0),
                        physics: BouncingScrollPhysics(),
                        controller: new ScrollController(),
                        children: menu
                            .map((menuitem) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MyCustomRoute(
                                      builder: (context) => ExcerciseView(
                                            data: menuitem,
                                          )));
                                },
                                child: Row(
                                  children: [
                                    CircleImage(
                                      image: menuitem['image'],
                                      height: 80 * Screen.height,
                                      width: 80 * Screen.width,
                                    ),
                                    Container(
                                      // width:
                                      //     MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.all(20 * Screen.scale),
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Text(menuitem['title'],
                                          style: TextStyle(
                                              fontFamily: 'Athiti',
                                              fontSize: 30 * Screen.scale)),
                                    )
                                  ],
                                )))
                            .toList())))
          ],
        ));
  }
}
