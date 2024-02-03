import 'package:common_widgets/gen/app_asset.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

class TmdbAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TmdbAppBar({
    super.key,
  });

  @override
  State<TmdbAppBar> createState() => _TmdbAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(61);
}

class _TmdbAppBarState extends State<TmdbAppBar> {
  bool shouldDisplaySearchBar = false;
  final TextEditingController searchController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          AppAsset.images.tmdbHorizontalLogo.image(
            package: "common_widgets",
            height: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: shouldDisplaySearchBar
                  ? TextField(
                      key: UniqueKey(),
                      autofocus: true,
                      controller: searchController,
                      onSubmitted: (s) {
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
                  : Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        key: UniqueKey(),
                        onPressed: () {
                          setState(() {
                            shouldDisplaySearchBar = true;
                          });
                        },
                        icon: const Icon(Icons.search),
                      ),
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
