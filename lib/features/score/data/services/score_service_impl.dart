import '../../../../core/logger/app_logger.dart';
import '../../../../models/user_model.dart';
import '../../../auth/login/presentation/viewmodels/auth_viewmodel.dart';
import '../../domain/entities/score_entry_model.dart';
import '../../domain/entities/score_summary_model.dart';
import '../repositories/score_repository.dart';
import 'score_service.dart';

class ScoreServiceImpl implements ScoreService {
  final ScoreRepository _repository;
  final AuthViewModel _authViewModel;
  final AppLogger _logger;

  ScoreServiceImpl({
    required ScoreRepository repository,
    required AuthViewModel authViewModel,
    required AppLogger logger,
  })  : _repository = repository,
        _authViewModel = authViewModel,
        _logger = logger;

  UserModel? get _currentUser => _authViewModel.userLogged;

  @override
  Future<List<ScoreEntryModel>> getMyScores({DateTime? date}) async {
    final user = _currentUser;
    if (user == null) {
      _logger.warning('No user logged in to fetch scores');
      return [];
    }

    final scores = await _repository.fetchScores(date: date);
    return scores
        .where((s) => s.nickname == user.nickname)
        .toList();
  }

  @override
  Future<List<ScoreEntryModel>> getMyScoresByRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final user = _currentUser;
    if (user == null) {
      _logger.warning('No user logged in to fetch scores');
      return [];
    }

    return _repository.fetchScoresWithFilters(
      nickname: user.nickname,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<ScoreSummaryModel> getMySummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final scores = await getMyScoresByRange(
      startDate: startDate,
      endDate: endDate,
    );

    final pointsByDate = <String, int>{};
    var totalPoints = 0;

    for (final score in scores) {
      totalPoints += score.points;
      final dateKey = score.formattedDate;
      pointsByDate[dateKey] = (pointsByDate[dateKey] ?? 0) + score.points;
    }

    return ScoreSummaryModel(
      totalPoints: totalPoints,
      totalEntries: scores.length,
      pointsByDate: pointsByDate,
    );
  }
}
