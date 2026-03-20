import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';

class ScoreWeekDayCell extends StatelessWidget {
  const ScoreWeekDayCell({
    super.key,
    required this.dayNumber,
    required this.points,
    required this.isToday,
    required this.isCurrentMonth,
  });

  final String dayNumber;
  final int points;
  final bool isToday;
  final bool isCurrentMonth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.accent.withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isToday
            ? Border.all(color: AppColors.accent, width: 1.5)
            : null,
      ),
      child: Column(
        children: [
          Text(
            dayNumber,
            style: TextStyle(
              color: isCurrentMonth ? Colors.white : Colors.white38,
              fontSize: 13,
              fontFamily: 'Ibrand',
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            points > 0 ? '$points' : '-',
            style: TextStyle(
              color: points > 0 ? AppColors.cosmicAccent : Colors.white24,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ibrand',
            ),
          ),
        ],
      ),
    );
  }
}
