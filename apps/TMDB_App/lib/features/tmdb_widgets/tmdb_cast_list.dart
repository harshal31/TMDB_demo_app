import 'package:common_widgets/theme/app_theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';

class TmdbCastList extends StatelessWidget {
  final List<Cast>? model;
  final double? height;
  final double? width;
  final Function()? onViewAllClick;
  final Function(int)? onItemClick;

  const TmdbCastList({
    super.key,
    required this.model,
    this.height,
    this.width,
    this.onViewAllClick,
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    final models = model?.take(10).toList() ?? [];
    return SizedBox(
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
                  onItemClick?.call(index);
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
                      ExtendedImage.network(
                        models[index].getImage(),
                        width: width ?? 138,
                        height: 175,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        cache: true,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            models[index].originalName ?? "",
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            models[index].character ?? "",
                            style: context.textTheme.labelMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
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
    );
  }
}
