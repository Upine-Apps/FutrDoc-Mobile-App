import 'package:flutter/material.dart';

import 'package:futr_doc/theme/pdfTheme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../custom-widgets/halfCircle.dart';
import 'pdfData.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
PdfGraphics? canvas;

Future<Uint8List> generatePdf(PdfPageFormat format, PdfData data) async {
  final doc = pw.Document(title: 'FutrDoc Report');
  final pageTheme = await _myPageTheme(format);
  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/pdf-header.png'))
        .buffer
        .asUint8List(),
  );
  final futrdocLogo = pw.MemoryImage(
    (await rootBundle.load('assets/images/futrdoc-logo-dark.png'))
        .buffer
        .asUint8List(),
  );
  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Container(
          width: format.availableWidth * 2,
          child: pw.Column(
            children: <pw.Widget>[
              pw.Image(profileImage),
              pw.SizedBox(height: 25),
              pw.Container(
                width: format.availableWidth * 1,
                child: pw.Column(
                  children: [
                    pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        padding: pw.EdgeInsets.only(left: 10),
                        child: pw.Text('${data.first_name} ${data.last_name}',
                            style: pw.Theme.of(context).header0)),
                    pw.Divider(),
                    pw.SizedBox(height: 20),
                    pw.Container(
                      height: format.availableHeight * .35,
                      decoration: pw.BoxDecoration(
                        color: lightGrey,
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.Row(
                        children: [
                          pw.Container(
                              padding: pw.EdgeInsets.only(
                                left: format.availableWidth * .025,
                                right: format.availableWidth * .025,
                              ),
                              // width: format.availableWidth * .2,
                              decoration: pw.BoxDecoration(
                                color: futrdocBlue,
                                borderRadius: pw.BorderRadius.circular(10),
                              ),
                              child: pw.Center(child: pw.Image(futrdocLogo))),
                          pw.SizedBox(width: format.availableWidth * .05),
                          pw.Container(
                            width: format.availableWidth * .3,
                            child: pw.Column(
                              children: [
                                pw.SizedBox(
                                    height: format.availableWidth * .05),
                                pw.Text('Report ID',
                                    style: pw.Theme.of(context).header1),
                                pw.Container(
                                    height: (format.availableHeight * .35) -
                                        (format.availableWidth * .15),
                                    decoration: pw.BoxDecoration(
                                      color: futrdocBlue,
                                      borderRadius:
                                          pw.BorderRadius.circular(10),
                                    ),
                                    child: pw.Column(children: [
                                      pw.Text(
                                          'Date : ${DateFormat("yMd").format(DateTime.now())}',
                                          style: pw.Theme.of(context).header5),
                                      pw.Text(
                                          'Time : ${DateFormat("jm").format(DateTime.now())}',
                                          style: pw.Theme.of(context).header5),
                                    ])),
                                pw.SizedBox(
                                    height: format.availableWidth * .05),
                              ],
                            ),
                          ),
                          pw.VerticalDivider(
                              indent: format.availableWidth * .045,
                              endIndent: format.availableWidth * .045,
                              thickness: 2),
                          pw.Container(
                            width: format.availableWidth * .3,
                            child: pw.Column(
                              children: [
                                pw.SizedBox(
                                    height: format.availableWidth * .025),
                                pw.Text('Student Info',
                                    style: pw.Theme.of(context).header1),
                                pw.SizedBox(
                                    height: format.availableWidth * .025),
                                pw.Container(
                                    height: (format.availableHeight * .35) -
                                        (format.availableWidth * .15),
                                    decoration: pw.BoxDecoration(
                                      color: futrdocBlue,
                                      borderRadius:
                                          pw.BorderRadius.circular(10),
                                    ),
                                    child: pw.Column(children: [
                                      pw.SizedBox(
                                          height: format.availableWidth *
                                              .015), //temporarily in place of padding
                                      pw.Text('University/College',
                                          style: pw.Theme.of(context)
                                              .header5
                                              .copyWith(
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                          textScaleFactor: 1),
                                      pw.Text('${data.institution}',
                                          style: pw.Theme.of(context).header5,
                                          textScaleFactor: 0.75),
                                      pw.Text('Degree/Major',
                                          style: pw.Theme.of(context)
                                              .header5
                                              .copyWith(
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                          textScaleFactor: 1),
                                      pw.Text('${data.degree}',
                                          style: pw.Theme.of(context).header5,
                                          textScaleFactor: 0.75),
                                    ])),
                                pw.SizedBox(
                                    height: format.availableWidth * .05),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Container(
                      height: 100,
                      decoration: pw.BoxDecoration(
                        color: lightGrey,
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.Column(
                        children: [
                          pw.Container(
                            height: 30,
                            decoration: pw.BoxDecoration(
                              color: futrdocBlue,
                              borderRadius: pw.BorderRadius.circular(5),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                'Student Overview',
                                style: pw.Theme.of(context).header4,
                              ),
                            ),
                          ),
                          pw.Container(
                            height: 70,
                            alignment: pw.Alignment.center,
                            padding: pw.EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: pw.Text(
                                '${data.first_name} ${data.last_name} accumulated a total of ${data.total_hours} clinical shadowing hours since ${DateFormat("MMMM").format(data.first_shadowing_date)} ${data.first_shadowing_date.year}. ${data.first_name} has extensive shadowing experience in ${data.top_icd_1}, ${data.top_icd_2}, and ${data.top_icd_3}.',
                                style: pw.Theme.of(context).header2,
                                textScaleFactor: 1),
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      padding: pw.EdgeInsets.only(left: 10),
                      child: pw.Row(
                        children: [
                          pw.Text('Clinical Shadowing Report',
                              style: pw.Theme.of(context).header1),
                          pw.Spacer(),
                          pw.Text(
                              'Date Range: ${DateFormat("yMd").format(data.first_shadowing_date)} - ${DateFormat("yMd").format(DateTime.now())}',
                              style: pw.Theme.of(context).header2)
                        ],
                      ),
                    ),
                    pw.Divider(),
                    pw.SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  return doc.save();
}

// const PdfData(
//       this.first_name,
//       this.last_name,
//       this.institution,
//       this.degree,
//       this.total_hours,
//       this.first_shadowing_date,
//       this.top_icd_1,
//       this.top_icd_2,
//       this.top_icd_3,
//       this.shadowings);

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/images/futrdoc-logo.svg');

  format = format.copyWith(
      marginBottom: 0, marginLeft: 0, marginRight: 0, marginTop: 0);
  return pw.PageTheme(
    pageFormat: format,
    theme: await getPdfTheme(),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: false,
      );
    },
  );
}

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, PdfData data);

class FutrDocPdf {
  const FutrDocPdf(this.name, this.file, this.builder);
  final String name;
  final String file;
  final LayoutCallbackWithData builder;
}
