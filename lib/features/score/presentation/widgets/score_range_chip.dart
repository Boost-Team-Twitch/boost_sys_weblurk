import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../domain/entities/date_range_filter.dart';

class ScoreRangeChip extends StatelessWidget {
  const ScoreRangeChip({
    super.key,
    required this.filter,
    required this.isSelected,
    required this.onSelected,
  });

  final DateRangeFilter filter;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        filter.label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontFamily: 'Ibrand',
          fontSize: 16,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.accent,
      checkmarkColor: Colors.white,
      backgroundColor: AppColors.cosmicPurple,
      side: BorderSide(
        color: isSelected ? AppColors.accent : AppColors.cosmicBorder,
      ),
      onSelected: (_) => onSelected(),
    );
  }
}
