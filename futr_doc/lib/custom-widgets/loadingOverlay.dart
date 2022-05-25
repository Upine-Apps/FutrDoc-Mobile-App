import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:futr_doc/theme/appColor.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({required Key key}) : super(key: key);
  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  final bool isLoading = true;

  void _showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Container(
          child: SpinKitWave(
              color: Colors.white, size: 25.0, type: SpinKitWaveType.start));
    });
  }

  // return OverlayEntry(
  //     builder: (context) => Positioned(
  //           left: offset.dx,
  //           top: offset.dy + size.height + 5.0,
  //           width: size.width,
  //           child: spinkit,
  //         ));

  @override
  Widget build(BuildContext context) {
    return TextFormField(decoration: InputDecoration(labelText: 'Loading'));
  }
}
