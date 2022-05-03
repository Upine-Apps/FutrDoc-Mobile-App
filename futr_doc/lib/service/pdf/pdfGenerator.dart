import 'package:flutter/material.dart';

import 'package:futr_doc/theme/pdfTheme.dart';
import 'package:pdf/pdf.dart';

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'pdfData.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generatePdf(PdfPageFormat format, PdfData data) async {
  final doc = pw.Document(title: 'FutrDoc Report');
  final pageTheme = await _myPageTheme(format);
  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text('${data.first_name} ${data.last_name}',
                            // textScaleFactor: 2,
                            style: pw.Theme.of(context)
                                .header2
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Text(data.institution,
                            style: pw.Theme.of(context)
                                .header1
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Text(data.degree,
                            style: pw.Theme.of(context)
                                .header1
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                        pw.Text('Shadowings: ${data.shadowings.length}',
                            style: pw.Theme.of(context).header1.copyWith(
                                  fontWeight: pw.FontWeight.bold,
                                )),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Container(
                              width: format.availableWidth * .5,
                              height: format.availableHeight * .15,
                              decoration: pw.BoxDecoration(
                                color: lighterBlue,
                                borderRadius: pw.BorderRadius.circular(10),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text(data.top_icd_1,
                                      style:
                                          pw.Theme.of(context).header4.copyWith(
                                                fontWeight: pw.FontWeight.bold,
                                              )),
                                  pw.Text(data.top_icd_2,
                                      style:
                                          pw.Theme.of(context).header4.copyWith(
                                                fontWeight: pw.FontWeight.bold,
                                              )),
                                  pw.Text(data.top_icd_3,
                                      style:
                                          pw.Theme.of(context).header4.copyWith(
                                                fontWeight: pw.FontWeight.bold,
                                              )),
                                ],
                              ),
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text(
                                    'Shadowing hours completed: ${data.total_hours}',
                                    style:
                                        pw.Theme.of(context).header5.copyWith(
                                              fontWeight: pw.FontWeight.bold,
                                            )),
                                // _UrlText('p.charlesbois@yahoo.com',
                                //     'mailto:p.charlesbois@yahoo.com'),
                                // _UrlText(
                                //     'wholeprices.ca', 'https://wholeprices.ca'),
                              ],
                            ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                      ],
                    ),
                  ),
                  // _Category(title: 'Work Experience'),
                  // _Block(
                  //     title: 'Tour bus driver',
                  //     icon: const pw.IconData(0xe530)),
                  // _Block(
                  //     title: 'Logging equipment operator',
                  //     icon: const pw.IconData(0xe30d)),
                  // _Block(title: 'Foot doctor', icon: const pw.IconData(0xe3f3)),
                  // _Block(
                  //     title: 'Unicorn trainer',
                  //     icon: const pw.IconData(0xf0cf)),
                  // _Block(
                  //     title: 'Chief chatter', icon: const pw.IconData(0xe0ca)),
                  // pw.SizedBox(height: 20),
                  // _Category(title: 'Education'),
                  // _Block(title: 'Bachelor Of Commerce'),
                  // _Block(title: 'Bachelor Interior Design'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/images/futrdoc-logo.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: await getPdfTheme(),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                  angle: pi, child: pw.SvgImage(svg: bgShape)),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
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
