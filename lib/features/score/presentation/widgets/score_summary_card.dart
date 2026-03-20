import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../domain/entities/score_summary_model.dart';
import 'score_stat_item.dart';

class ScoreSummaryCard extends StatelessWidget {
  const ScoreSummaryCard({super.key, required this.summary});

  final ScoreSummaryModel? summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.cosmicPurple,
            AppColors.cosmicDarkPurple,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cosmicBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          ScoreStatItem(
            icon: Icons.star_rounded,
            label: 'Total de Pontos',
            value: '${summary?.totalPoints ?? 0}',
            color: AppColors.cosmicAccent,
          ),
          const SizedBox(width: 32),
          ScoreStatItem(
            icon: Icons.calendar_today_rounded,
            label: 'Dias Ativos',
            value: '${summary?.pointsByDate.length ?? 0}',
            color: AppColors.success,
          ),
        ],
      ),
    );
  }
}
