import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;

  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.height,
      this.width,
      this.color,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(text,
                style: TextStyle(color: textColor != null ? textColor : Theme.of(context).primaryColor)),
            style: ElevatedButton.styleFrom(
                primary: color,
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: 'Share'
                ))));
  }
}
