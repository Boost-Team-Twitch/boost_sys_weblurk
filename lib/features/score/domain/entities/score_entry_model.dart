class ScoreEntryModel {
  final int id;
  final int streamerId;
  final DateTime date;
  final int hour;
  final int minute;
  final int points;
  final String nickname;

  const ScoreEntryModel({
    required this.id,
    required this.streamerId,
    required this.date,
    required this.hour,
    required this.minute,
    required this.points,
    required this.nickname,
  });

  factory ScoreEntryModel.fromMap(Map<String, dynamic> map) {
    return ScoreEntryModel(
      id: map['id'] as int? ?? 0,
      streamerId: map['streamerId'] as int? ?? 0,
      date: map['date'] != null
          ? DateTime.parse(map['date'] as String)
          : DateTime.now(),
      hour: map['hour'] as int? ?? 0,
      minute: map['minute'] as int? ?? 0,
      points: map['points'] as int? ?? 0,
      nickname: map['nickname'] as String? ?? '',
    );
  }

  String get formattedTime =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  String get formattedDate =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}
