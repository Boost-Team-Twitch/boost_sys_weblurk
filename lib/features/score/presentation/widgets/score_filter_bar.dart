import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../domain/entities/date_range_filter.dart';
import 'score_date_selector.dart';
import 'score_range_chip.dart';

class ScoreFilterBar extends StatelessWidget {
  const ScoreFilterBar({
    super.key,
    required this.selectedDate,
    required this.selectedFilter,
    required this.onDateTap,
    required this.onFilterSelected,
  });

  final DateTime selectedDate;
  final DateRangeFilter selectedFilter;
  final VoidCallback onDateTap;
  final ValueChanged<DateRangeFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.cosmicDarkPurple,
        border: Border(
          bottom: BorderSide(color: AppColors.cosmicBorder),
        ),
      ),
      child: Row(
        children: [
          ScoreDateSelector(
            selectedDate: selectedDate,
            onTap: onDateTap,
          ),
          const SizedBox(width: 16),
          ...DateRangeFilter.values.map(
            (filter) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ScoreRangeChip(
                filter: filter,
                isSelected: selectedFilter == filter,
                onSelected: () => onFilterSelected(filter),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
