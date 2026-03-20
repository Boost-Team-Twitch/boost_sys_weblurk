import 'package:flutter/material.dart';

class ScoreStatItem extends StatelessWidget {
  const ScoreStatItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ibrand',
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontFamily: 'Ibrand',
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
