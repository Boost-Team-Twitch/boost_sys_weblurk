class ScoreWeekDayModel {
  final DateTime date;
  final String dayNumber;
  final int points;
  final bool isToday;
  final bool isCurrentMonth;

  const ScoreWeekDayModel({
    required this.date,
    required this.dayNumber,
    required this.points,
    required this.isToday,
    required this.isCurrentMonth,
  });
}
