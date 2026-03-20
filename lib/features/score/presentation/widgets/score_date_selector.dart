import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/ui/app_colors.dart';

class ScoreDateSelector extends StatelessWidget {
  const ScoreDateSelector({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  final DateTime selectedDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cosmicBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.calendar_today,
              color: Colors.white70,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              DateFormat('dd/MM/yyyy').format(selectedDate),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Ibrand',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
