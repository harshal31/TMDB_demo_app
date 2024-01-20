import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_recommendations.dart';

class TmdbRecomendations extends StatelessWidget {
  final MediaDetail? detail;
  final List<RecommendationResults> recommendations;

  TmdbRecomendations({
    super.key,
    required this.recommendations,
    required this.detail,
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
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ExtendedImage.network(
              recommendations[index].backDropImage,
              width: 250,
              height: 141,
              fit: BoxFit.fill,
              cache: true,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              cacheMaxAge: Duration(minutes: 30),
            ),
          );
        },
      ),
    );
  }
}
