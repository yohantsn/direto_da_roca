import 'package:flutter/material.dart';
import 'package:horta_ui/utils/horta_assets.dart';

class HortaScaffold extends StatelessWidget {
  final Widget body;
  const HortaScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          image: DecorationImage(
            image: AssetImage(HortaAssets.background),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.05), BlendMode.dstATop),
          ),
        ),
        child: body,
      ),
    );
  }
}
