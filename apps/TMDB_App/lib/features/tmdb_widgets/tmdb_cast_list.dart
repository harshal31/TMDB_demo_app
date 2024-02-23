import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class TmdbCastList extends StatelessWidget {
  final List<Cast>? model;
  final MediaDetail? mediaDetail;
  final double? height;
  final double? width;

  const TmdbCastList({
    super.key,
    required this.model,
    this.height,
    this.width,
    this.mediaDetail,
  });

  @override
  Widget build(BuildContext context) {
    final models = model?.take(10).toList() ?? [];
    return Visibility(
      visible: models.isNotEmpty,
      child: Scrollbar(
        child: SizedBox(
          height: height ?? 245,
          child: ListView.builder(
            itemCount: models.length,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return Padding(
                key: ValueKey(index),
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: width ?? 138,
                  child: GestureDetector(
                    onTap: () {
                      CommonNavigation.redirectToDetailScreen(
                        context,
                        mediaType: ApiKey.person,
                        mediaId: model?[index].id?.toString() ?? "",
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ExtendedImageCreator(
                            imageUrl: models[index].getImage(),
                            width: width ?? 138,
                            height: 175,
                            fit: BoxFit.cover,
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: WrappedText(
                                    models[index].originalName ?? "",
                                    style: context.textTheme.labelMedium?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: WrappedText(
                                    models[index].character ?? "",
                                    style: context.textTheme.labelMedium,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      replacement: WrappedText(
        context.tr.noCastPresent(
          mediaDetail?.getActualName(mediaDetail?.type == ApiKey.movie) ?? "",
        ),
        style: context.textTheme.titleMedium,
      ),
    );
  }
}
