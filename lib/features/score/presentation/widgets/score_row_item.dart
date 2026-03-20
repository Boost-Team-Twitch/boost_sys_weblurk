import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../domain/entities/score_entry_model.dart';

class ScoreRowItem extends StatelessWidget {
  const ScoreRowItem({super.key, required this.score});

  final ScoreEntryModel score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.cosmicBorder, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '+${score.points}',
              style: const TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ibrand',
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  score.formattedDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Ibrand',
                  ),
                ),
                Text(
                  score.formattedTime,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    fontFamily: 'Ibrand',
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${score.points} pts',
            style: const TextStyle(
              color: AppColors.cosmicAccent,
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
