import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futr_doc/service/pdf/pdfGenerator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../service/pdf/pdfData.dart';

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  void initState() {
    super.initState();
    getTheme();
  }

  getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      theme = prefs.getString('Theme') ?? 'Light';
    });
  }

  String theme = '';
  final pdf =
      FutrDocPdf('Report', '../..service/pdf/pdfGenerator.dart', generatePdf);
  var _data = PdfData('Tate', 'Walker', 'Upine Apps University', 'Aerospace',
      20, DateTime.now(), 'first icd', 'second icd', 'third icd', []);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          // body: Align(
          //   alignment: Alignment.topCenter,
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: [
          //         SizedBox(
          //           height: MediaQuery.of(context).size.height * .075,
          //         ),
          //         Container(
          //           padding: EdgeInsets.only(
          //               left: MediaQuery.of(context).size.width * .05),
          //           alignment: Alignment.centerLeft,
          //           child: IconButton(
          //             icon: Icon(Icons.arrow_back_ios,
          //                 color: Theme.of(context).secondaryHeaderColor),
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //           ),
          //         ),
          //         Text(
          //           'PDF',
          //           style: Theme.of(context).textTheme.headline2,
          //           textAlign: TextAlign.center,
          //         ),
          //         SizedBox(height: MediaQuery.of(context).size.height * .025),
          body: PdfPreview(
        build: (format) => pdf.builder(format, _data),
        allowPrinting: false,
      )
          // ],
          // ),
          // ),
          // ),
          ),
    );
  }
}
