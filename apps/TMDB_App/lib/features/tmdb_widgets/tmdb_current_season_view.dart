import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        WrappedText(
                          context.tr.season(season?.seasonNumber ?? 0),
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  WrappedText(
                    '• ${season?.getAirDate()} • ${season?.episodeCount ?? 0} Episodes',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  WrappedText(
                    context.tr.seasonOfMessage(
                      lastEpisodeToAir?.airDate?.formatDateInMMMMFormat ?? "",
                      season?.seasonNumber ?? "",
                      season?.name ?? "",
                    ),
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      WrappedText(
                        context.tr.season(season?.seasonNumber ?? 0),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  WrappedText(
                    '• ${season?.getAirDate()} • ${season?.episodeCount ?? 0} Episodes',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  WrappedText(
                    context.tr.seasonOfMessage(
                      lastEpisodeToAir?.airDate?.formatDateInMMMMFormat ?? "",
                      season?.seasonNumber ?? "",
                      season?.name ?? "",
                    ),
                    style: context.textTheme.titleSmall,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 8),
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
          ),
        ],
      ),
    );
  }
}
