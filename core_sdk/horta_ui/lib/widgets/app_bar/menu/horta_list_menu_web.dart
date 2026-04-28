import 'package:flutter/material.dart';
import 'package:horta_ui/widgets/padding/horta_padding.dart';

class HortaListMenuSectionWeb extends StatelessWidget {
  const HortaListMenuSectionWeb({
    super.key,
    required this.menuItems,
    required this.onItemPressed,
    required this.selectedItem,
  });

  final List<String> menuItems;
  final String selectedItem;
  final Function(String menuItem) onItemPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: menuItems.map((item) {
          return _HortaListMenuItemWeb(
            parameters: HortaListMenuItemParameters(
              title: item,
              isSelected: item == selectedItem,
              onPressed: onItemPressed,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _HortaListMenuItemWeb extends StatelessWidget {
  const _HortaListMenuItemWeb({required this.parameters});

  final HortaListMenuItemParameters parameters;

  @override
  Widget build(BuildContext context) {
    return HortaPadding(
      padding: .symmetric(horizontal: .medium),
      child: parameters.isSelected
          ? OutlinedButton(
              onPressed: () => parameters.onPressed(parameters.title),
              child: Text(
                parameters.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : TextButton(
              onPressed: () => parameters.onPressed(parameters.title),
              child: Text(
                parameters.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
    );
  }
}

class HortaListMenuItemParameters {
  final String title;
  final Function(String title) onPressed;
  final bool isSelected;

  HortaListMenuItemParameters({
    required this.title,
    required this.onPressed,
    this.isSelected = false,
  });
}
