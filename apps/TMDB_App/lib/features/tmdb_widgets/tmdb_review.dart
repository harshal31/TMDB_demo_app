import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/read_more_text.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';

class TmdbReview extends StatelessWidget {
  final ReviewResults? result;
  final MediaDetail? mediaDetail;
  final bool shouldUseAnimatedReadMe;

  const TmdbReview({
    super.key,
    required this.result,
    this.mediaDetail,
    this.shouldUseAnimatedReadMe = true,
  });

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return WrappedText(
        context.tr.noReviews(mediaDetail?.getActualName(mediaDetail?.type == ApiKey.movie) ?? ""),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: context.colorTheme.primary,
                  // Replace with actual image or initial
                  child: result?.authorDetails?.avatarPath?.isNotEmpty ?? false
                      ? ExtendedImageCreator(
                          imageUrl: result?.authorDetails?.getAvatar() ?? "",
                          fit: BoxFit.fill,
                          shape: BoxShape.circle,
                          width: double.infinity,
                          height: double.infinity,
                          borderRadius: BorderRadius.zero,
                        )
                      : WrappedText(
                          (result?.author?.length ?? 0) > 0
                              ? ((result?.author ?? "A")[0]).toUpperCase()
                              : "A",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorTheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WrappedText(
                        context.tr.aReviewBy(result?.author ?? ""),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Visibility(
                            visible: result?.authorDetails?.rating != null,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
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
                                        result?.authorDetails?.rating.toString() ?? "",
                                        style: context.textTheme.titleSmall?.copyWith(
                                          color: context.colorTheme.onPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                          Expanded(
                            child: WrappedText(
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
            Visibility(
              visible: shouldUseAnimatedReadMe,
              child: AnimatedReadMoreText(
                result?.content ?? "",
                maxLines: 5,
                readMoreText: context.tr.readMore,
                readLessText: context.tr.readLess,
                textStyle: context.textTheme.bodyMedium,
              ),
              replacement: WrappedText(
                result?.content ?? "",
                style: context.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
