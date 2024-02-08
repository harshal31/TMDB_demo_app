import 'package:common_widgets/common_utils/currency_conversion.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_keywords.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_detail.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_share.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

class TmdbSideView extends StatelessWidget {
  final MediaDetail? mediaDetail;
  final List<Keywords> keywords;
  final double? keywordSpacing;

  const TmdbSideView({
    super.key,
    this.mediaDetail,
    required this.keywords,
    this.keywordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: mediaDetail?.status?.isNotEmpty ?? false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.status,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  mediaDetail?.status ?? "",
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: mediaDetail?.originalLanguage?.isNotEmpty ?? false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.originalLanguage,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  mediaDetail?.originalLanguage ?? "",
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: mediaDetail?.budget?.formatCurrencyInDollar.isNotEmpty ?? false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.budget,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  mediaDetail?.budget?.formatCurrencyInDollar ?? "-",
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: mediaDetail?.revenue?.formatCurrencyInDollar.isNotEmpty ?? false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.revenue,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  mediaDetail?.revenue?.formatCurrencyInDollar ?? "-",
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Text(
            context.tr.keywords,
            style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: keywords.isNotEmpty,
            child: Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: keywordSpacing ?? 8.0, // gap between lines
              children: List<Widget>.generate(
                keywords.length,
                (int index) {
                  return ActionChip(
                    onPressed: () {
                      context.push(
                        Uri(
                          path:
                              "${RouteName.home}/${RouteName.keywords}/${RouteParam.movie}/${keywords[index].id}",
                        ).toString(),
                        extra: keywords[index].name ?? "",
                      );
                    },
                    label: Text(
                      keywords[index].name ?? "",
                      style: context.textTheme.titleSmall,
                    ),
                    backgroundColor: context.colorTheme.surface,
                  );
                },
              ),
            ),
            replacement: Text(
              context.tr.noKeywords,
              style: context.textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class TmdbTvSeriesSideView extends StatelessWidget {
  final MediaDetail? mediaDetail;
  final List<Keywords> keywords;
  final double? keywordSpacing;

  const TmdbTvSeriesSideView({
    super.key,
    this.mediaDetail,
    required this.keywords,
    this.keywordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.facts,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: mediaDetail?.budget?.formatCurrencyInDollar.isNotEmpty ?? false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.budget,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  mediaDetail?.budget?.formatCurrencyInDollar ?? "-",
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: mediaDetail?.status?.isNotEmpty ?? false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.status,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  mediaDetail?.status ?? "",
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Text(
            context.tr.network,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Visibility(
            visible: mediaDetail?.networks?.isNotEmpty ?? false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mediaDetail?.networks?.length ?? 0,
                    itemBuilder: (ctx, index) {
                      return Container(
                        padding: const EdgeInsets.only(right: 4),
                        child: InkWell(
                          onTap: () {
                            context.push(
                              Uri(
                                path:
                                    "${RouteName.home}/${RouteName.network}/${RouteParam.tv}/${mediaDetail?.networks?[index].id}",
                              ).toString(),
                              extra: mediaDetail?.networks?[index].name ?? "",
                            );
                          },
                          child: ExtendedImageCreator(
                            imageUrl: mediaDetail?.networks?[index].getNetworkImage() ?? "",
                            height: 30,
                            fit: BoxFit.cover,
                            imageColor: context.colorTheme.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            replacement: Text(
              context.tr.noNetworkForTvSeriesAvailable,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: mediaDetail?.originalLanguage?.isNotEmpty ?? false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.originalLanguage,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  mediaDetail?.originalLanguage ?? "",
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: mediaDetail?.type?.isNotEmpty ?? false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.type,
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  mediaDetail?.type ?? "",
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Text(
            context.tr.keywords,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: keywords.isNotEmpty,
            child: Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: keywordSpacing ?? 8.0, // gap between lines
              children: List<Widget>.generate(
                keywords.length,
                (int index) {
                  return ActionChip(
                    onPressed: () {
                      context.push(
                        Uri(
                          path:
                              "${RouteName.home}/${RouteName.keywords}/${RouteParam.tv}/${keywords[index].id}",
                        ).toString(),
                        extra: keywords[index].name ?? "",
                      );
                    },
                    label: Text(
                      keywords[index].name ?? "",
                      style: context.textTheme.titleSmall,
                    ),
                    backgroundColor: context.colorTheme.surface,
                  );
                },
              ),
            ),
            replacement: Text(
              context.tr.noKeywords,
              style: context.textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class TmdbSidePersonView extends StatelessWidget {
  final PersonDetail? personDetail;
  final MediaExternalId? tmdbShare;

  const TmdbSidePersonView({
    super.key,
    this.personDetail,
    this.tmdbShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TmdbShare(
            tmdbShareModel: tmdbShare,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.personalInfo,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.knownFor,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  personDetail?.knownForDepartment ?? "",
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.gender,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  personDetail?.genderString ?? "",
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.birthday,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${personDetail?.birthday ?? ""} ${personDetail?.getYearsOld(context) ?? ""}",
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.placeOfBirth,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  personDetail?.placeOfBirth ?? "",
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.alsoKnownAs,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  personDetail?.alsoKnownAsString ?? "",
                  style: context.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
