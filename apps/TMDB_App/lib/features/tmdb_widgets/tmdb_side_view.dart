import 'package:common_widgets/common_utils/currency_conversion.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_keywords.dart';

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
          Text(
            context.tr.status,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            mediaDetail?.status ?? "",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.originalLanguage,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            mediaDetail?.originalLanguage ?? "",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.budget,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            mediaDetail?.budget?.formatCurrencyInDollar ?? "-",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.revenue,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            mediaDetail?.revenue?.formatCurrencyInDollar ?? "-",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
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
                    onPressed: () {},
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
          Text(
            context.tr.status,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            mediaDetail?.status ?? "",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.network,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mediaDetail?.networks?.length ?? 0,
              itemBuilder: (ctx, index) {
                return ExtendedImage.network(
                  mediaDetail?.networks?[index].getNetworkImage() ?? "",
                  height: 30,
                  cache: true,
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  cacheMaxAge: const Duration(minutes: 30),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.originalLanguage,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            mediaDetail?.originalLanguage ?? "",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.type,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            mediaDetail?.type ?? "",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
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
                    onPressed: () {},
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
