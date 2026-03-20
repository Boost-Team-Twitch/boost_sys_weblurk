import '../../domain/entities/score_entry_model.dart';
import '../../domain/entities/score_summary_model.dart';

abstract interface class ScoreService {
  Future<List<ScoreEntryModel>> getMyScores({DateTime? date});

  Future<List<ScoreEntryModel>> getMyScoresByRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<ScoreSummaryModel> getMySummary({
    required DateTime startDate,
    required DateTime endDate,
  });
}
