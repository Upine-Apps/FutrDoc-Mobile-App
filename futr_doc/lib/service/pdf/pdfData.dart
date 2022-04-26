import '../../models/Shadowing.dart';

class PdfData {
  const PdfData(
      this.first_name,
      this.last_name,
      this.institution,
      this.degree,
      this.total_hours,
      this.first_shadowing_date,
      this.top_icd_1,
      this.top_icd_2,
      this.top_icd_3,
      this.shadowings);

  final String first_name;
  final String last_name;
  final String institution;
  final String degree;
  final int total_hours;
  final DateTime first_shadowing_date;
  final String top_icd_1;
  final String top_icd_2;
  final String top_icd_3;
  final List<Shadowing> shadowings;
}
