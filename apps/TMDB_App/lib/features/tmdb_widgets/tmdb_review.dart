import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';

class TmdbReview extends StatelessWidget {
  final ReviewResults? result;
  final MediaDetail? mediaDetail;

  const TmdbReview({
    super.key,
    required this.result,
    required this.mediaDetail,
  });

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return Text(
        context.tr.noReviews(mediaDetail?.originalTitle ?? ""),
        style: context.textTheme.titleMedium,
      );
    }

    return Card(
      color: context.colorTheme.surface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: context.colorTheme.primary,
                  // Replace with actual image or initial
                  child: result?.authorDetails?.avatarPath?.isNotEmpty ?? false
                      ? ExtendedImageCreator(
                          imageUrl: result?.authorDetails?.getAvatar() ?? "",
                          fit: BoxFit.cover,
                          shape: BoxShape.circle,
                        )
                      : Text(
                          'P',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorTheme.onPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr.aReviewBy(result?.authorDetails?.name ?? ""),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
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
                                Text(
                                  result?.authorDetails?.rating.toString() ?? "",
                                  style: context.textTheme.titleSmall?.copyWith(
                                    color: context.colorTheme.onPrimary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              context.tr.writtenBy(result?.authorDetails?.name ?? "",
                                  result?.createdAt.formatDateInMMMMFormat ?? ""),
                              style: context.textTheme.titleSmall?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            AnimatedReadMoreText(
              result?.content ?? "",
              maxLines: 5,
              readMoreText: context.tr.readMore,
              readLessText: context.tr.readLess,
              textStyle: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
