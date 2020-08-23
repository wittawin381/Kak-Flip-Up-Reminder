import 'package:demo/screenconfig/screen.dart';
import 'package:demo/sharedComponents/myAppBar.dart';
import 'package:demo/style.dart';
import 'package:flutter/material.dart';
import '../sharedComponents/circleimage.dart';
import 'postureView.dart';
import '../sharedComponents/myButton.dart';

class PostureListView extends StatefulWidget {
  @override
  _PostureListViewState createState() => _PostureListViewState();
}

class _PostureListViewState extends State<PostureListView>
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
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageSlideController.dispose();
  }

  List<Map<String, dynamic>> menu = [
    {
      'title': 'ท่านอนหงาย',
      'image': 'assets/postures/face.png',
      'view': null,
      'images': [
        'assets/postures/face/image1.jpeg',
        'assets/postures/face/image2.jpeg',
        'assets/postures/face/image3.jpeg'
      ],
      'step': [
        '- ให้ผู้ป่วยนอนหนุนหมอนรองรับบริเวณคอและศีรษะ ไม่แหงนหน้า (หมอนเตี้ย) หรือคอพับเกินไป (หมอนสูง) \n\n- ผู้ป่วยนอนเหยียดแขนสบายๆ มือหงาย หรือคว่ำก็ได้อาจมาวางไว้บนหน้าอก \n\n- นำผ้าขนหนูม้วนเป็นก้อนกลมๆ ใส่ไว้ในมือ',
        '- ลำตัวเหยียดตรง ขาเหยียดตรง อาจงอเข่าเล็กน้อย \n\n- ใช้ผ้าขนหนูเล็ก ๆ รองตรงหลัง ข้อพับเข่า ข้อเท้า',
        '- ปลายเท้ากระดกขึ้น โดยใช้หมอน หรือผ้าห่มดันฝ่าเท้า \n\n- วางหมอนข้าง ข้างสะโพกผู้ป่วย',
      ],
      'sound': 'face.mp3'
    },
    {
      'title': 'ท่านอนตะแคง',
      'image': 'assets/postures/lean.png',
      'view': null,
      'images': [
        'assets/postures/lean/image1.jpeg',
        'assets/postures/lean/image2.jpeg'
      ],
      'step': [
        '- เริ่มจากท่านอนหงาย ให้หมอนหนุนศีรษะแล้วค่อย ๆ พลิกตะแคงตัวผู้ป่วยช้า ๆ ระวังน้ำหนักตัวจะทับไหล่ข้างที่ตะแคงลง อาจเกิดการปวดได้ โดยให้ศีรษะโน้มไปข้างหน้าเล็กน้อย \n\n - เหยียดแขนด้านที่พลิกตะแคงออกไป เพื่อไม่ให้ลำตัวทับ และแขนข้างบน ให้ไหล่โน้มไปข้างหน้า ใช้หมอนรองโดยใช้หมอนข้าง หรือหมอนสูง',
        '\n- ขาข้างบนงอ ก่ายบนหมอนข้างขาด้านล่างเหยียดตรง',
        '\n- ใช้หมอนดันหนุนข้างหลัง',
      ],
      'sound': 'lean.mp3'
    },
    {
      'title': 'ท่านอนหงายศรีษะสูง',
      'image': 'assets/postures/facehighhead.png',
      'view': null,
      'images': ['assets/postures/facehighhead/image1.jpeg'],
      'step': [
        '- จากท่านอนหงายค่อยประคองตัวผู้ป่วยขึ้น ให้ลำตัวตั้งประมาณ 45 องศาแล้วใช้หมอนหนุนลำตัว \n\n - ใช้ผ้าขนหนูม้วนกลมรองใต้เข่า \n\n - ปลายเท้ากระดกขึ้น ใช้หมอนหรือผ้าห่มรอง \n\n - วางหมอนรองแขนทั้งสองข้างและมือกำผ้าม้วนกลม',
      ],
      'sound': 'facehighhead.mp3'
    },
    {
      'title': 'ท่านอนตะแคงเกือบคว่ำ',
      'image': 'assets/postures/leandown.png',
      'view': null,
      'images': ['assets/postures/leandown/image1.jpeg'],
      'step': [
        '\-ใช้ในกรณีนอนคว่ำไม่ได้' +
            '\n\n -จัดท่าผู้ป่วยจากท่าให้นอนตะแคงศีรษะหันไปด้านที่ตะแคง' +
            '\n\n -แขนด้านที่ตะแคงกางไหล่และงอข้อศอกคว่ำมือลงบนหมอนในท่าสบายๆส่วนแขนอีกข้างงอไหล่ แต่เหยียดแขนลงวางข้างลำตัว' +
            '\n\n -ขาด้านตะแคงงอ ใช้หมอนหนุนใต้เข่า อีกข้างเหยียดตรง',
      ],
      'sound': 'leandown.mp3'
    },
  ];
  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    pageSlideController.forward();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          MyAppBar(
            title: "Postures",
            backButton: true,
            onBackButtonPress: () {
              pageSlideController.reverse();
            },
          ),
          SlideTransition(
              position: pageSlideAnimation,
              child: Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(0),
                    children: menu
                        .asMap()
                        .map((i, e) => MapEntry(
                            i,
                            MainMenuButton(
                              title: e['title'],
                              image: Hero(
                                tag: i,
                                child: CircleImage(
                                  image: e['image'],
                                  width: 120 * Screen.scale,
                                  height: 120 * Screen.scale,
                                ),
                              ),
                              view: PostureView(
                                title: e['title'],
                                data: e,
                                tag: i,
                              ),
                              onPressed: () {},
                            )))
                        .values
                        .toList(),
                  )))
        ]));
  }
}
