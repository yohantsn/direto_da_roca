import 'package:flutter/material.dart';

class HortaInputText extends StatelessWidget {
  final Widget child;
  const HortaInputText._({super.key, required this.child});

  factory HortaInputText.search(
    BuildContext context, {
    Key? key,
    TextEditingController? controller,
    String? hintText,
    Function(String)? onChanged,
  }) {
    final colors = Theme.of(context).colorScheme;
    return HortaInputText._(
      key: key,
      child: Container(
        margin: .symmetric(horizontal: 24),
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(25),
          border: .all(color: colors.outline),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(Icons.search, color: colors.primary),
            border: .none,
            contentPadding: .symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
