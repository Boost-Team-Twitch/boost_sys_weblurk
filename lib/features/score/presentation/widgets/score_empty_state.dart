import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';

class ScoreEmptyState extends StatelessWidget {
  const ScoreEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cosmicDarkPurple,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cosmicBorder.withValues(alpha: 0.5),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.emoji_events_outlined,
            color: Colors.white38,
            size: 48,
          ),
          SizedBox(height: 12),
          Text(
            'Nenhuma pontuação encontrada',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16,
              fontFamily: 'Ibrand',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Sua pontuação aparecerá aqui quando houver registros',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 13,
              fontFamily: 'Ibrand',
            ),
          ),
        ],
      ),
    );
  }
}
