import 'package:common_widgets/gen/app_asset.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

class TmdbAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController? controller;
  final bool? shouldDisplaySearchBar;
  final bool? shouldDisplayBack;
  final Function(String)? onSubmitted;

  const TmdbAppBar({
    super.key,
    this.controller,
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
  late bool shouldDisplaySearchBar = widget.shouldDisplaySearchBar ?? false;
  late final TextEditingController searchController =
      widget.controller ?? TextEditingController(text: "");

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: shouldDisplaySearchBar
                  ? TextField(
                      key: UniqueKey(),
                      autofocus: true,
                      controller: searchController,
                      onSubmitted: (s) {
                        if (widget.onSubmitted != null) {
                          widget.onSubmitted?.call(s);
                          return;
                        }
                        searchController.clear();
                        setState(() {
                          shouldDisplaySearchBar = false;
                        });
                        context.push(
                          Uri(
                            path: "${RouteName.home}/${RouteName.search}/${RouteParam.movie}",
                            queryParameters: {RouteParam.query: s},
                          ).toString(),
                        );
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.colorTheme.primary,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                searchController.clear();
                                return;
                              }
                              if (widget.onSubmitted != null) {
                                return;
                              }

                              setState(() {
                                shouldDisplaySearchBar = false;
                              });
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        hintText: context.tr.searchFor,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            final path =
                                GoRouter.of(context).routeInformationProvider.value.uri.path;
                            if (path != RouteName.home) {
                              context.push(RouteName.home);
                            }
                          },
                          child: AppAsset.images.tmdbHorizontalLogo.image(
                            package: "common_widgets",
                            height: 30,
                          ),
                        ),
                        IconButton(
                          key: UniqueKey(),
                          onPressed: () {
                            setState(() {
                              shouldDisplaySearchBar = true;
                            });
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
