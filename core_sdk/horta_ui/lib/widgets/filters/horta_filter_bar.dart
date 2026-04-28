import 'package:flutter/material.dart';
import 'package:horta_ui/horta_ui.dart';

class HortaFilterBar extends StatefulWidget {
  final List<String> categories;
  final String defaultCategory;
  final Function(String)? onCategorySelected;
  const HortaFilterBar({
    super.key,
    required this.categories,
    required this.defaultCategory,
    this.onCategorySelected,
  });

  @override
  _HortaFilterBarState createState() => _HortaFilterBarState();
}

class _HortaFilterBarState extends State<HortaFilterBar> {
  String? _selectedCategory;

  @override
  void initState() {
    _selectedCategory = widget.defaultCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const .symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          mainAxisSize: .max,
          children: widget.categories.map((category) {
            bool isSelected = _selectedCategory == category;
            return HortaPadding(
              padding: .only(right: .small),
              child: HortaFilterChip(
                category: category,
                isSelected: isSelected,
                onSelected: (bool selected) {
                  widget.onCategorySelected?.call(category);
                  setState(() => _selectedCategory = category);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
