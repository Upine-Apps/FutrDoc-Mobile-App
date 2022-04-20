class OverviewBody {
  int totalDuration;
  int monthlyDuration;
  int totalSpecialties;
  int totalShadowingCount;

  OverviewBody(
      {required this.totalDuration,
      required this.monthlyDuration,
      required this.totalSpecialties,
      required this.totalShadowingCount});

  static OverviewBody emptyOverviewBody() => new OverviewBody(
      totalDuration: 0,
      monthlyDuration: 0,
      totalSpecialties: 0,
      totalShadowingCount: 0);

  static OverviewBody jsonToOverview(data) {
    return OverviewBody(
        totalDuration: data['totalDuration'],
        monthlyDuration: data['monthlyDuration'],
        totalSpecialties: data['totalSpecialties'],
        totalShadowingCount: data['totalShadowingCount']);
  }
}
