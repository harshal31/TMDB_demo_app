import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';

class TmdbCurrentSeasonView extends StatelessWidget {
  final Season? season;
  final LastEpisodeToAir? lastEpisodeToAir;

  const TmdbCurrentSeasonView({
    super.key,
    required this.season,
    this.lastEpisodeToAir,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExtendedImageCreator(
            imageUrl: season?.getSeasonImage() ?? "",
            width: 130,
            height: 195,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WrappedText(
                    context.tr.season(season?.seasonNumber ?? 0),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: context.colorTheme.primary,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: context.colorTheme.onPrimary,
                                size: 15,
                              ),
                              const SizedBox(width: 8),
                              WrappedText(
                                season?.voteAverage.toString() ?? "",
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: context.colorTheme.onPrimary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        WrappedText(
                          '• ${season?.getAirDate()} • ${season?.episodeCount ?? 0} Episodes',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  WrappedText(
                    season?.overview ?? "",
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WrappedText(
                          '${lastEpisodeToAir?.name ?? ""} (${season?.seasonNumber ?? 0}x${season?.episodeCount ?? 0}}, ${lastEpisodeToAir?.airDate?.formatDateInMMMMFormat ?? ""})',
                          style: context.textTheme.titleMedium,
                        ),
                        const SizedBox(width: 4),
                        Visibility(
                          visible: lastEpisodeToAir?.episodeType?.isNotEmpty ?? false,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorTheme.primary,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: WrappedText(
                              context.tr.season(lastEpisodeToAir?.episodeType ?? ""),
                              style: context.textTheme.titleSmall?.copyWith(
                                color: context.colorTheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TmdbCurrentSeasonMobileView extends StatelessWidget {
  final Season? season;
  final LastEpisodeToAir? lastEpisodeToAir;

  const TmdbCurrentSeasonMobileView({
    super.key,
    required this.season,
    this.lastEpisodeToAir,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExtendedImageCreator(
                imageUrl: season?.getSeasonImage() ?? "",
                width: 130,
                height: 195,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WrappedText(
                        context.tr.season(season?.seasonNumber ?? 0),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: context.colorTheme.primary,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: context.colorTheme.onPrimary,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 8),
                                  WrappedText(
                                    season?.voteAverage.toString() ?? "",
                                    style: context.textTheme.titleSmall?.copyWith(
                                      color: context.colorTheme.onPrimary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            WrappedText(
                              '• ${season?.getAirDate()} • ${season?.episodeCount ?? 0} Episodes',
                              style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      WrappedText(
                        season?.overview ?? "",
                        style: context.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          WrappedText(
            '${lastEpisodeToAir?.name ?? ""} (${season?.seasonNumber ?? 0}x${season?.episodeCount ?? 0}}, ${lastEpisodeToAir?.airDate?.formatDateInMMMMFormat ?? ""})',
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 2),
          Visibility(
            visible: lastEpisodeToAir?.episodeType?.isNotEmpty ?? false,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 6.0,
              ),
              decoration: BoxDecoration(
                color: context.colorTheme.primary,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: WrappedText(
                context.tr.season(lastEpisodeToAir?.episodeType ?? ""),
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorTheme.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
