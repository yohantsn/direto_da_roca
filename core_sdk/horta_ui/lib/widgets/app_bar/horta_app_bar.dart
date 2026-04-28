import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:horta_ui/widgets/app_bar/menu/horta_list_menu_web.dart';

class HortaAppBarDelegate extends SliverPersistentHeaderDelegate {
  HortaAppBarDelegate({required this.leadingImagePath, this.webMenuItems});
  final String leadingImagePath;
  final HortaListMenuSectionWeb? webMenuItems;

  @override
  double get maxExtent => 90.0;

  @override
  double get minExtent => 90.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double imageSize = 80;

    return Material(
      elevation: 1.5,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const .symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Row(
              mainAxisAlignment: webMenuItems != null ? .start : .center,
              children: [
                Container(
                  padding: .only(right: 8),
                  width: imageSize,
                  height: imageSize,
                  decoration: const BoxDecoration(shape: .circle),
                  child: ClipRRect(
                    borderRadius: .circular(100),
                    child: Image.asset(leadingImagePath, fit: .contain),
                  ),
                ),
                if (kIsWeb) webMenuItems ?? const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HortaAppBarDelegate oldDelegate) => true;
}
