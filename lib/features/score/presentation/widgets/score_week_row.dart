import 'package:flutter/material.dart';

import '../../domain/entities/score_week_day_model.dart';
import 'score_week_day_cell.dart';

class ScoreWeekRow extends StatelessWidget {
  const ScoreWeekRow({super.key, required this.days});

  final List<ScoreWeekDayModel> days;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: days
          .map(
            (day) => Expanded(
              child: ScoreWeekDayCell(
                dayNumber: day.dayNumber,
                points: day.points,
                isToday: day.isToday,
                isCurrentMonth: day.isCurrentMonth,
              ),
            ),
          )
          .toList(),
    );
  }
}
