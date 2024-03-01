import 'package:common_widgets/gen/app_asset.dart';
import 'package:common_widgets/theme/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_animated_icon_switcher.dart';
import 'package:tmdb_app/routes/route_name.dart';

class TmdbAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool? shouldDisplaySearchBar;
  final bool? shouldDisplayBack;
  final Function(String)? onSubmitted;

  const TmdbAppBar({
    super.key,
    this.shouldDisplaySearchBar,
    this.onSubmitted,
    this.shouldDisplayBack,
  });

  @override
  State<TmdbAppBar> createState() => _TmdbAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(61);
}

class _TmdbAppBarState extends State<TmdbAppBar> {
  @override
  Widget build(BuildContext context) {
    final shouldBack = widget.shouldDisplayBack ?? false;
    return Container(
      height: 61,
      padding: EdgeInsets.only(left: shouldBack ? 8 : 16, right: 16),
      decoration: BoxDecoration(
        color: context.colorTheme.background,
        border: Border(
          bottom: BorderSide(
            color: context.colorTheme.onSurface.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Visibility(
            visible: widget.shouldDisplayBack ?? false,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    final path = GoRouter.of(context).routeInformationProvider.value.uri.path;
                    if (path != RouteName.home) {
                      context.push(RouteName.home);
                    }
                  },
                  child: AppAsset.images.tmdbHorizontalLogo.image(
                    package: "common_widgets",
                    height: 30,
                  ),
                ),
                Expanded(child: Container()),
                TmdbAnimatedIconSwitcher(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
