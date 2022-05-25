class DataDashboardBody {
  dynamic filteredDashboardData;
  String firstShadowingMonth;
  int firstShadowingYear;
  int totalDuration;

  DataDashboardBody(
      {required this.filteredDashboardData,
      required this.firstShadowingMonth,
      required this.firstShadowingYear,
      required this.totalDuration});

  static DataDashboardBody emptyDataDashboardBody() => new DataDashboardBody(
      filteredDashboardData: {},
      firstShadowingMonth: '',
      firstShadowingYear: 0,
      totalDuration: 0);

  static DataDashboardBody jsonToDataDashboard(data) {
    return DataDashboardBody(
        filteredDashboardData: data['filteredDashboardData'],
        firstShadowingMonth: data['firstShadowingMonth'],
        firstShadowingYear: data['firstShadowingYear'],
        totalDuration: data['totalDuration']);
  }
}
