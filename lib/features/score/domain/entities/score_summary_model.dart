class ScoreSummaryModel {
  final int totalPoints;
  final int totalEntries;
  final Map<String, int> pointsByDate;

  const ScoreSummaryModel({
    required this.totalPoints,
    required this.totalEntries,
    required this.pointsByDate,
  });
}
