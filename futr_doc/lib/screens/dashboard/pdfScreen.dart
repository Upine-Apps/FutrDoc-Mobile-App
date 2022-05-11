import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futr_doc/service/pdf/pdfGenerator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../service/pdf/pdfData.dart';
import '../../theme/appColor.dart';

class PdfScreen extends StatefulWidget {
  final dynamic shadowingData;
  final dynamic userData;
  PdfScreen({required this.userData, required this.shadowingData});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  void initState() {
    super.initState();
    getTheme();
  }

  var _data = PdfData('Tate', 'Walker', 'Upine Apps University', 'Aerospace',
      20, DateTime.now(), 'first icd', 'second icd', 'third icd');

  getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      theme = prefs.getString('Theme') ?? 'Light';
    });
  }

  String theme = '';
  final pdf =
      FutrDocPdf('Report', '../..service/pdf/pdfGenerator.dart', generatePdf);

  @override
  Widget build(BuildContext context) {
    print(widget.userData);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          appBar: AppBar(
            title: Text('FutrDoc Report',
                style: Theme.of(context).textTheme.headline3),
            leading: Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .05),
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).secondaryHeaderColor,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
          ),
          body: PdfPreview(
              build: (format) =>
                  pdf.builder(format, widget.userData, widget.shadowingData),
              allowPrinting: false,
              canChangeOrientation: false,
              canChangePageFormat: false,
              canDebug: false)),
    );
  }
}
