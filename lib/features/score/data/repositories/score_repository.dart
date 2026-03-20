import '../../domain/entities/score_entry_model.dart';

abstract interface class ScoreRepository {
  Future<List<ScoreEntryModel>> fetchScores({DateTime? date});

  Future<List<ScoreEntryModel>> fetchScoresWithFilters({
    String? nickname,
    DateTime? startDate,
    DateTime? endDate,
    int? startHour,
    int? endHour,
  });
}
