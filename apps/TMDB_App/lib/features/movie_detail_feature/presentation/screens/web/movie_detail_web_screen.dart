import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:common_widgets/widgets/tmdb_icon.dart';
import 'package:common_widgets/widgets/tooltip_rating.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_cast_list.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_media_view.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_recomendations%20.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_review.dart';

class MovieDetailWebScreen extends StatelessWidget {
  const MovieDetailWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 570,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Opacity(
                    opacity: 0.3,
                    child: ExtendedImage.network(
                      "https://image.tmdb.org/t/p/original/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
                      cache: true,
                      fit: BoxFit.cover,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      cacheMaxAge: Duration(hours: 1),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.colorTheme.primaryContainer.withOpacity(0.5),
                          context.colorTheme.primaryContainer.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                    child: Row(
                      children: [
                        ExtendedImage.network(
                          "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
                          width: 300,
                          height: 450,
                          fit: BoxFit.fill,
                          cache: true,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          cacheMaxAge: Duration(hours: 1),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "The Marvels ",
                                        style: context.textTheme.headlineLarge?.copyWith(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "(2023)",
                                          style: context.textTheme.headlineLarge?.copyWith(
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "11/10/2023",
                                          style: context.textTheme.titleMedium,
                                        ),
                                        TextSpan(
                                          text: " . ",
                                          style: context.textTheme.headlineLarge,
                                        ),
                                        TextSpan(
                                          text: "Action,Adventure",
                                          style: context.textTheme.titleMedium,
                                        ),
                                        TextSpan(
                                          text: " . ",
                                          style: context.textTheme.headlineLarge,
                                        ),
                                        TextSpan(
                                          text: "1h 45m",
                                          style: context.textTheme.titleMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TmdbIcon(
                                        iconSize: 20,
                                        icons: (Icons.favorite, Icons.favorite_outline_sharp),
                                        isSelected: false,
                                        selectedColor: Colors.red,
                                        onSelection: (s) {},
                                        hoverMessage: context.tr.markAsFavorite,
                                      ),
                                      const SizedBox(width: 30),
                                      TmdbIcon(
                                        iconSize: 20,
                                        icons: (Icons.bookmark, Icons.bookmark_outline_sharp),
                                        isSelected: false,
                                        selectedColor: Colors.red,
                                        onSelection: (s) {},
                                        hoverMessage: context.tr.addToWatchlist,
                                      ),
                                      const SizedBox(width: 30),
                                      TooltipRating(
                                        rating: 0,
                                        iconSize: 20,
                                        hoverMessage: context.tr.addToWatchlist,
                                        onRatingUpdate: (rating) {},
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Tagline, Action Higher Energetic",
                                    style: context.textTheme.titleMedium?.copyWith(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w100,
                                        color: context.colorTheme.onBackground.withOpacity(0.6)),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    context.tr.overview,
                                    style: context.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Why do we use it?It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                                    style: context.textTheme.titleSmall,
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    height: 60,
                                    child: ListView.separated(
                                      separatorBuilder: (ctx, index) => const Divider(indent: 80),
                                      itemCount: 3,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Person",
                                                style: context.textTheme.bodyLarge?.copyWith(
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Director",
                                                style: context.textTheme.bodyMedium,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
          sliver: SliverCrossAxisGroup(
            slivers: [
              SliverCrossAxisExpanded(
                flex: 2,
                sliver: SliverList.list(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr.topBilledCast,
                            style: context.textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            size: 40,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TmdbCastList(models: tmdbModelList),
                    const SizedBox(height: 16),
                    Divider(
                      color: context.colorTheme.onBackground.withOpacity(0.6),
                      thickness: 2.0,
                      height: 1.0,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr.reviews,
                            style: context.textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            size: 40,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TmdbReview(),
                    const SizedBox(height: 16),
                    Divider(
                      color: context.colorTheme.onBackground.withOpacity(0.6),
                      thickness: 2.0,
                      height: 1.0,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr.media,
                            style: context.textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            size: 40,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: CustomTabBar(
                        titles: [
                          context.tr.videos,
                          context.tr.backdrops,
                          context.tr.posters,
                        ],
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        selectedColor: context.colorTheme.primaryContainer,
                        onSelectedTab: (pos) {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    TmdbMediaView(pos: 0),
                    const SizedBox(height: 16),
                    Divider(
                      color: context.colorTheme.onBackground.withOpacity(0.6),
                      thickness: 2.0,
                      height: 1.0,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr.recommendations,
                            style: context.textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            size: 40,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TmdbRecomendations(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              SliverCrossAxisExpanded(
                flex: 1,
                sliver: SliverToBoxAdapter(
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
