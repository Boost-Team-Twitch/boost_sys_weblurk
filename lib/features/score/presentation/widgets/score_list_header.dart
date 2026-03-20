import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';

class ScoreListHeader extends StatelessWidget {
  const ScoreListHeader({super.key, required this.totalEntries});

  final int totalEntries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_events,
            color: AppColors.cosmicAccent,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Histórico ($totalEntries registros)',
            style: const TextStyle(
              color: Colors.white,
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
