import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../domain/entities/score_week_day_model.dart';
import 'score_week_row.dart';

class ScoreCalendarGrid extends StatelessWidget {
  const ScoreCalendarGrid({
    super.key,
    required this.weeks,
    required this.dateRangeLabel,
  });

  final List<List<ScoreWeekDayModel>> weeks;
  final String dateRangeLabel;

  static const _dayHeaders = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

  @override
  Widget build(BuildContext context) {
    if (weeks.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cosmicDarkPurple,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cosmicBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            dateRangeLabel,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontFamily: 'Ibrand',
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: _dayHeaders
                .map(
                  (h) => Expanded(
                    child: Text(
                      h,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ibrand',
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          ...weeks.map(
            (week) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: ScoreWeekRow(days: week),
            ),
          ),
        ],
      ),
    );
  }
}
