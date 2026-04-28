import 'package:flutter/material.dart';
import 'package:horta_ui/utils/horta_assets.dart';
import 'package:horta_ui/widgets/app_bar/horta_app_bar.dart';

class HortaScaffold extends StatelessWidget {
  final List<Widget> children;
  final HortaAppBarDelegate? appBarDelegate;

  const HortaScaffold({super.key, required this.children, this.appBarDelegate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: .infinity,
        height: .infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          image: DecorationImage(
            image: AssetImage(HortaAssets.background),
            fit: .cover,
            colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.01), .dstATop),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            if (appBarDelegate != null) SliverPersistentHeader(pinned: true, floating: true, delegate: appBarDelegate!),

            SliverList(delegate: SliverChildListDelegate(children)),
          ],
        ),
      ),
    );
  }
}
