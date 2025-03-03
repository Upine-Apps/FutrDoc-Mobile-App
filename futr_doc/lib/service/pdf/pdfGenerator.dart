import 'package:futr_doc/theme/pdfTheme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdfData.dart';

var pdfHeader;
var futrdocLogo;
var _data;
var _shadowings;

Future<Uint8List> generatePdf(
    PdfPageFormat format, PdfData data, dynamic shadowings) async {
  _data = data;
  _shadowings = shadowings;
  final doc = pw.Document(title: 'FutrDoc Report');
  final pageTheme = await _myPageTheme(format);
  pdfHeader = pw.MemoryImage(
    (await rootBundle.load('assets/images/pdf-header.png'))
        .buffer
        .asUint8List(),
  );

  futrdocLogo = pw.MemoryImage(
    (await rootBundle.load('assets/images/futrdoc-logo-dark.png'))
        .buffer
        .asUint8List(),
  );
  doc.addPage(
    pw.MultiPage(
      header: _buildHeader,
      pageTheme: pageTheme,
      build: (context) => [
        _contentHeader(context, format),
        _contentTable(context, format),
      ],
    ),
  );
  return doc.save();
}

pw.Widget _buildHeader(pw.Context context) {
  return pw.Container(child: pdfHeader != null ? pw.Image(pdfHeader) : null);
}

pw.Widget _contentHeader(pw.Context context, PdfPageFormat format) {
  return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
    pw.Expanded(
      child: pw.Container(
        margin: pw.EdgeInsets.symmetric(horizontal: 72.5),
        width: format.availableWidth * 1,
        child: pw.Column(
          children: [
            pw.SizedBox(height: 25),
            pw.Container(
                alignment: pw.Alignment.centerLeft,
                padding: pw.EdgeInsets.only(left: 10),
                child: pw.Text('${_data.first_name} ${_data.last_name}',
                    style: pw.Theme.of(context).header0)),
            pw.Divider(),
            pw.SizedBox(height: 20),
            pw.Container(
              height: format.availableHeight * .3,
              decoration: pw.BoxDecoration(
                color: lightGrey,
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                      width: format.availableWidth * .2,
                      padding: pw.EdgeInsets.only(
                        left: format.availableWidth * .025,
                        right: format.availableWidth * .025,
                      ),
                      decoration: pw.BoxDecoration(
                        color: futrdocBlue,
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: futrdocLogo != null
                          ? pw.Center(child: pw.Image(futrdocLogo))
                          : null),
                  pw.SizedBox(width: 20),
                  pw.Container(
                    width: 340,
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // pw.SizedBox(height: 20),
                        pw.Text(
                            'Date: ${DateFormat("yMd").format(DateTime.now())}',
                            style: pw.Theme.of(context).header1),
                        //  pw.SizedBox(height: 10),
                        pw.Text(
                            'Time: ${DateFormat("jm").format(DateTime.now())}',
                            style: pw.Theme.of(context).header1,
                            textAlign: pw.TextAlign.left),
                        // pw.SizedBox(height: 10),
                        pw.Text('University/College: ${_data.institution}',
                            style: pw.Theme.of(context).header1),
                        //  pw.SizedBox(height: 10),

                        pw.Text('Degree/Major: ${_data.degree}',
                            style: pw.Theme.of(context).header1)
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
                      child: pw.RichText(
                          text: pw.TextSpan(children: [
                        pw.TextSpan(
                          text: '${_data.first_name} ${_data.last_name} ',
                          style: pw.Theme.of(context)
                              .header2
                              .copyWith(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.TextSpan(
                          text: 'accumulated a total of ',
                          style: pw.Theme.of(context).header2,
                        ),
                        pw.TextSpan(
                          text:
                              '${_data.total_hours} clinical shadowing hours ',
                          style: pw.Theme.of(context)
                              .header2
                              .copyWith(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.TextSpan(
                          text: 'since ',
                          style: pw.Theme.of(context).header2,
                        ),
                        pw.TextSpan(
                          text:
                              '${DateFormat('MMMM').format(_data.first_shadowing_date)}  ${_data.first_shadowing_date.year}. ',
                          style: pw.Theme.of(context)
                              .header2
                              .copyWith(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.TextSpan(
                          text:
                              '${_data.first_name} has extensive shadowing experience in ',
                          style: pw.Theme.of(context).header2,
                        ),
                        pw.TextSpan(
                          text: '${_data.top_icd_1}, ${_data.top_icd_2}, ',
                          style: pw.Theme.of(context)
                              .header2
                              .copyWith(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.TextSpan(
                          text: 'and ',
                          style: pw.Theme.of(context).header2,
                        ),
                        pw.TextSpan(
                          text: '${_data.top_icd_3}.',
                          style: pw.Theme.of(context)
                              .header2
                              .copyWith(fontWeight: pw.FontWeight.bold),
                        ),
                      ]))),
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
                      style: pw.Theme.of(context).header2),
                  pw.Spacer(),
                  pw.Text(
                      'Date Range: ${DateFormat("yMd").format(_data.first_shadowing_date)} - ${DateFormat("yMd").format(DateTime.now())}',
                      style: pw.Theme.of(context).header2)
                ],
              ),
            ),
            pw.Divider(height: 1),
          ],
        ),
      ),
    ),
  ]);
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

pw.Widget _contentTable(pw.Context context, PdfPageFormat format) {
  const tableHeaders = ['Date', 'Duration (HR)', 'Clinic Name', 'ICD10'];
  return pw.Container(
      padding: pw.EdgeInsets.only(left: 72.5, right: 72.5, top: 25),
      child: pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: pw.BoxDecoration(
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
          color: futrdocBlue,
        ),
        headerHeight: 25,
        cellHeight: 30,
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerLeft,
          3: pw.Alignment.centerLeft,
        },
        headerStyle: pw.TextStyle(
          color: offWhite,
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
        ),
        cellStyle: pw.TextStyle(
          color: darkGrey,
          fontSize: 10,
        ),
        oddRowDecoration: pw.BoxDecoration(
          color: lightGrey,
        ),
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          _shadowings.length,
          (row) => List<String>.generate(
            tableHeaders.length,
            (col) => _shadowings[row].getIndexForPdf(col),
          ),
        ),
      ));
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  format = format.copyWith(
      marginBottom: 0, marginLeft: 0, marginRight: 0, marginTop: 0);
  return pw.PageTheme(
    pageFormat: format,
    theme: await getPdfTheme(),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
      );
    },
  );
}

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, PdfData data, dynamic shadowingData);

class FutrDocPdf {
  const FutrDocPdf(this.name, this.file, this.builder);
  final String name;
  final String file;
  final LayoutCallbackWithData builder;
}
