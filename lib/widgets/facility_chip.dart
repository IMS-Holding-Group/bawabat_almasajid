import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FacilityChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const FacilityChip({
    super.key,
    required this.label,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.lightGreen.withOpacity(0.2) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? AppTheme.lightGreen : Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          color: isActive ? AppTheme.darkGreen : Colors.grey.shade600,
          fontSize: 12,
        ),
      ),
    );
  }
}
