import 'package:flutter/material.dart';

enum HortaPaddingSize {
  /// 8.0
  small,

  /// 16.0
  medium,

  /// 24.0
  large,
}

extension HortaPaddingSizeExtension on HortaPaddingSize {
  double get value {
    switch (this) {
      case HortaPaddingSize.small:
        return 8.0;
      case HortaPaddingSize.medium:
        return 16.0;
      case HortaPaddingSize.large:
        return 24.0;
    }
  }
}

class HortaPadding extends StatelessWidget {
  final HortaEdgeInsets padding;
  final Widget child;
  const HortaPadding({super.key, required this.padding, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}

class HortaEdgeInsets extends EdgeInsets {
  HortaEdgeInsets.only({
    HortaPaddingSize? left,
    HortaPaddingSize? right,
    HortaPaddingSize? top,
    HortaPaddingSize? bottom,
  }) : super.only(
         left: left?.value ?? 0.0,
         right: right?.value ?? 0.0,
         top: top?.value ?? 0.0,
         bottom: bottom?.value ?? 0.0,
       );

  HortaEdgeInsets.all(HortaPaddingSize size) : super.all(size.value);

  const HortaEdgeInsets.none() : super.all(0.0);

  HortaEdgeInsets.symmetric({
    HortaPaddingSize? horizontal,
    HortaPaddingSize? vertical,
  }) : super.symmetric(
         vertical: vertical?.value ?? 0.0,
         horizontal: horizontal?.value ?? 0.0,
       );
}
