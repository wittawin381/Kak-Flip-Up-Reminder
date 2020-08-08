import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Photoview extends StatelessWidget {
  Photoview({this.image, this.tag});
  final String image;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Hero(
            tag: tag,
            child: PhotoView(
              imageProvider: AssetImage(image),
            )));
  }
}
