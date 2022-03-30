import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  final bool? spinner;
  final double? elevation;

  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.height,
      this.width,
      this.color,
      this.textColor,
      this.spinner,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
            onPressed: onPressed,
            child: spinner == true
                ? SpinKitWave(
                    color: Theme.of(context).secondaryHeaderColor,
                    size: 20.0,
                    type: SpinKitWaveType.start)
                : Text(text,
                    style: TextStyle(
                        color: textColor != null
                            ? textColor
                            : Theme.of(context).primaryColor)),
            style: ElevatedButton.styleFrom(
                elevation: elevation ?? 10,
                primary: color,
                textStyle: TextStyle(
                    fontSize: fontSize ?? 16,
                    fontWeight: fontWeight,
                    fontFamily: 'Share'))));
  }
}
