import 'package:demo/screenconfig/screen.dart';
import 'package:demo/sharedComponents/customMaterialRoute.dart';
import 'package:flutter/material.dart';
import 'customRoute.dart';

typedef OnPressed = void Function();

class MainMenuButton extends StatelessWidget {
  MainMenuButton({this.title, this.image, this.view, @required this.onPressed});
  final String title;
  final dynamic image;
  final dynamic view;
  final OnPressed onPressed;

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    // TODO: implement build
    return RawMaterialButton(
      onPressed: () {
        Navigator.of(context).push(MyCustomRoute(builder: (context) => view));
        this.onPressed();
        // Navigator.of(context).push(customRoute(
        //     this.view, context.findAncestorWidgetOfExactType<Scaffold>()));
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => view));
      },
      child: Container(
        height: 180 * Screen.scale,
        width: 180 * Screen.scale,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            // border: Border.all(color: Colors.black.withAlpha(40), width: 2.0),
            // gradient: LinearGradient(
            //     colors: [Color(0xffe6e6e6), Color(0xffffffff)],
            //     begin: Alignment(-1, -4),
            //     end: Alignment(1, 4)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 30,
                  spreadRadius: -12,
                  offset: Offset(5, 5),
                  color: Color(0xffa3b1c6)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            this.image,
            Text(
              this.title,
              style: TextStyle(
                  fontFamily: 'Athiti',
                  fontSize: 20 * Screen.scale,
                  color: Color(0xff222222)),
            )
          ],
        ),
      ),
    );
  }
}
