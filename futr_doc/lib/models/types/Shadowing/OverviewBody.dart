class OverviewBody {
  int totalDuration;
  int monthlyDuration;
  String topClinic;
  int totalShadowingCount;

  OverviewBody(
      {required this.totalDuration,
      required this.monthlyDuration,
      required this.topClinic,
      required this.totalShadowingCount});

  static OverviewBody emptyOverviewBody() => new OverviewBody(
      totalDuration: 0,
      monthlyDuration: 0,
      topClinic: '',
      totalShadowingCount: 0);

  static OverviewBody jsonToOverview(data) {
    return OverviewBody(
        totalDuration: data['totalDuration'],
        monthlyDuration: data['monthlyDuration'],
        topClinic: data['topClinic'],
        totalShadowingCount: data['totalShadowingCount']);
  }
}
