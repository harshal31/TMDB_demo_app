import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/constants/api_key.dart';
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
      return Text(
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
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                _redirectToDetailScreen(
                  context,
                  mediaType: mediaType,
                  mediaId: recommendations[index].id.toString(),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: ExtendedImageCreator(
                imageUrl: recommendations[index].backDropImage,
                width: 250,
                height: 141,
                fit: BoxFit.cover,
              ),
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
