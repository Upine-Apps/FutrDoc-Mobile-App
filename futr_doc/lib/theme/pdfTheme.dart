import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

PdfColor lighterBlue = new PdfColor.fromHex('#5D4EFF');
PdfColor primaryDARK = new PdfColor.fromHex('#191256');
PdfColor offWhite = new PdfColor.fromHex('#f5f5f5');
PdfColor darkGrey = new PdfColor.fromHex('#525151');

Future<ThemeData> getPdfTheme() async {
  return ThemeData.withFont(
    base: await fontFromAssetBundle('assets/fonts/Share-Regular.ttf'),
    bold: await fontFromAssetBundle('assets/fonts/Share-Bold.ttf'),
    icons: await PdfGoogleFonts.materialIcons(),
  ).copyWith(
    header0: TextStyle(color: primaryDARK, fontSize: 60),
    header1: TextStyle(color: primaryDARK, fontSize: 40),
    header2: TextStyle(color: primaryDARK, fontSize: 30),
    header3: TextStyle(color: offWhite, fontSize: 30),
    header4: TextStyle(color: offWhite, fontSize: 16),
    header5: TextStyle(color: darkGrey, fontSize: 16),
  );
}
