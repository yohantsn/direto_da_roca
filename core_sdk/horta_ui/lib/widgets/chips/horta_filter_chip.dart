import 'package:flutter/material.dart';

class HortaFilterChip extends StatelessWidget {
  final String category;
  final Function(bool)? onSelected;
  final bool isSelected;

  const HortaFilterChip({
    super.key,
    required this.category,
    required this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: isSelected ? colors.primary : Colors.black87,
      fontSize: 13,
      overflow: .ellipsis,
    );
    return Container(
      height: 50,
      padding: .only(right: 8),
      child: FilterChip(
        label: FittedBox(
          child: Text(category, style: labelStyle, textAlign: TextAlign.center),
        ),
        selected: isSelected,
        onSelected: onSelected,
        selectedColor: colors.outline.withValues(alpha: .3),
        checkmarkColor: colors.primary,
        labelStyle: labelStyle,
        shape: StadiumBorder(
          side: BorderSide(
            color: isSelected ? colors.primary : Colors.grey.shade300,
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
