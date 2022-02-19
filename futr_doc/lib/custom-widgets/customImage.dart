import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;

  const CustomImage({Key? key, required this.imagePath, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: Image(image: AssetImage(imagePath)),
    height: height,
    width: width
    );
  }
}