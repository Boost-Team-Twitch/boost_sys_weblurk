import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../domain/entities/score_entry_model.dart';
import 'score_empty_state.dart';
import 'score_list_header.dart';
import 'score_row_item.dart';

class ScoreListSection extends StatelessWidget {
  const ScoreListSection({super.key, required this.scores});

  final List<ScoreEntryModel> scores;

  @override
  Widget build(BuildContext context) {
    if (scores.isEmpty) {
      return const ScoreEmptyState();
    }

    return Container(
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
          ScoreListHeader(totalEntries: scores.length),
          const Divider(
            color: AppColors.cosmicBorder,
            height: 1,
          ),
          ...scores.map(
            (score) => ScoreRowItem(score: score),
          ),
        ],
      ),
    );
  }
}
