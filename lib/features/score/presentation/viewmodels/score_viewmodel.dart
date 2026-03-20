import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';

import '../../../../core/helpers/sentry_mixin.dart';
import '../../../../core/utils/command.dart';
import '../../../../core/utils/result.dart';
import '../../data/services/score_service.dart';
import '../../domain/entities/date_range_filter.dart';
import '../../domain/entities/score_entry_model.dart';
import '../../domain/entities/score_summary_model.dart';
import '../../domain/entities/score_week_day_model.dart';

class ScoreViewModel extends ChangeNotifier with SentryMixin {
  ScoreViewModel({required ScoreService scoreService})
    : _scoreService = scoreService;

  final ScoreService _scoreService;

  List<ScoreEntryModel> _scores = [];
  List<ScoreEntryModel> get scores => _scores;

  ScoreSummaryModel? _summary;
  ScoreSummaryModel? get summary => _summary;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  DateRangeFilter _rangeFilter = DateRangeFilter.today;
  DateRangeFilter get rangeFilter => _rangeFilter;

  List<List<ScoreWeekDayModel>> get calendarWeeks => _buildCalendarWeeks();

  String get dateRangeLabel => _buildDateRangeLabel();

  late final loadScoresCommand = Command0<List<ScoreEntryModel>>(
    () => _loadScores(),
  );

  late final loadSummaryCommand = Command0<ScoreSummaryModel>(
    () => _loadSummary(),
  );

  Future<Result<List<ScoreEntryModel>>> _loadScores() async {
    try {
      final range = _rangeFilter.toDateRange(_selectedDate);
      final scores = await _scoreService.getMyScoresByRange(
        startDate: range.start,
        endDate: range.end,
      );

      _scores = scores;
      notifyListeners();

      return Result.ok(scores);
    } catch (e) {
      await captureError(e, StackTrace.current, context: 'load_scores');
      return Result.error(Exception('Erro ao carregar pontuação'));
    }
  }

  Future<Result<ScoreSummaryModel>> _loadSummary() async {
    try {
      final range = _rangeFilter.toDateRange(_selectedDate);
      final summary = await _scoreService.getMySummary(
        startDate: range.start,
        endDate: range.end,
      );

      _summary = summary;
      notifyListeners();

      return Result.ok(summary);
    } catch (e) {
      await captureError(e, StackTrace.current, context: 'load_summary');
      return Result.error(Exception('Erro ao carregar resumo'));
    }
  }

  void changeDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
    loadScoresCommand.execute();
    loadSummaryCommand.execute();
  }

  void changeRangeFilter(DateRangeFilter filter) {
    _rangeFilter = filter;
    notifyListeners();
    loadScoresCommand.execute();
    loadSummaryCommand.execute();
  }

  void loadAll() {
    loadScoresCommand.execute();
    loadSummaryCommand.execute();
  }

  Map<String, int> get _pointsByDay {
    final map = <String, int>{};
    for (final score in _scores) {
      final key = DateFormat('yyyy-MM-dd').format(score.date);
      map[key] = (map[key] ?? 0) + score.points;
    }
    return map;
  }

  List<List<ScoreWeekDayModel>> _buildCalendarWeeks() {
    if (_rangeFilter == DateRangeFilter.today) return [];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final pointsMap = _pointsByDay;
    final range = _rangeFilter.toDateRange(_selectedDate);

    final DateTime gridStart;
    final int totalWeeks;

    if (_rangeFilter == DateRangeFilter.week) {
      gridStart = range.start;
      totalWeeks = 1;
    } else {
      final monthStart = DateTime(range.start.year, range.start.month);
      final weekdayOffset = (monthStart.weekday - 1) % 7;
      gridStart = monthStart.subtract(
        Duration(days: weekdayOffset),
      );
      totalWeeks = 4;
    }

    final weeks = <List<ScoreWeekDayModel>>[];

    for (var w = 0; w < totalWeeks; w++) {
      final week = <ScoreWeekDayModel>[];
      for (var d = 0; d < 7; d++) {
        final date = gridStart.add(Duration(days: w * 7 + d));
        final dateKey = DateFormat('yyyy-MM-dd').format(date);
        final dayDate = DateTime(date.year, date.month, date.day);

        week.add(
          ScoreWeekDayModel(
            date: date,
            dayNumber: date.day.toString().padLeft(2, '0'),
            points: pointsMap[dateKey] ?? 0,
            isToday: dayDate == today,
            isCurrentMonth: date.month == _selectedDate.month,
          ),
        );
      }
      weeks.add(week);
    }

    return weeks;
  }

  String _buildDateRangeLabel() {
    final range = _rangeFilter.toDateRange(_selectedDate);
    final fmt = DateFormat('dd/MM/yyyy');

    if (_rangeFilter == DateRangeFilter.today) {
      return fmt.format(range.start);
    }

    if (_rangeFilter == DateRangeFilter.week) {
      return '${fmt.format(range.start)} - ${fmt.format(range.end)}';
    }

    final monthStart = DateTime(range.start.year, range.start.month);
    final weekdayOffset = (monthStart.weekday - 1) % 7;
    final gridStart = monthStart.subtract(
      Duration(days: weekdayOffset),
    );
    final gridEnd = gridStart.add(
      const Duration(days: 27),
    );
    return '${fmt.format(gridStart)} - ${fmt.format(gridEnd)}';
  }
}
