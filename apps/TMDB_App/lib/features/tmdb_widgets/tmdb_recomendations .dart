import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_recommendations.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';
import 'package:tmdb_app/routes/route_name.dart';

class TmdbRecomendations extends StatelessWidget {
  final MediaDetail? detail;
  final String? mediaType;
  final List<RecommendationResults> recommendations;

  TmdbRecomendations({
    super.key,
    required this.recommendations,
    required this.detail,
    this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return WrappedText(
        context.tr.noRecommendation(detail?.originalTitle ?? ""),
        style: context.textTheme.titleMedium,
        textAlign: TextAlign.center,
      );
    }

    return SizedBox(
      height: 141,
      child: ListView.builder(
        itemCount: recommendations.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Padding(
            key: ValueKey(index),
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  surfaceTintColor: context.colorTheme.background,
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ExtendedImageCreator(
                    imageUrl: recommendations[index].backDropImage,
                    width: 250,
                    height: 141,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: context.colorTheme.primaryContainer.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        _redirectToDetailScreen(
                          context,
                          mediaType: mediaType,
                          mediaId: recommendations[index].id.toString(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _redirectToDetailScreen(
    BuildContext context, {
    String? mediaType = ApiKey.movie,
    String? mediaId = "609681",
  }) {
    context.push("${RouteName.home}/$mediaType/$mediaId");
  }
}
