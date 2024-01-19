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
    final models = model ?? [];
    return SizedBox(
      height: height ?? 245,
      child: ListView.builder(
        itemCount: models.isNotEmpty ? (models.length + 1) : 0,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          if (index == models.length) {
            return Container(
              key: ValueKey(index),
              alignment: Alignment.center,
              width: width ?? 138,
              height: height ?? 245,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_double_arrow_right_sharp,
                  size: 40,
                ),
                onPressed: () {
                  onViewAllClick?.call();
                },
              ),
            );
          }
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
                  shape: RoundedRectangleBorder(
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
                        fit: BoxFit.cover,
                        cache: true,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        cacheMaxAge: Duration(minutes: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Expanded(
                          child: Text(
                            models[index].originalName ?? "",
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Expanded(
                          child: Text(
                            models[index].character ?? "",
                            style: context.textTheme.labelMedium,
                            maxLines: 2,
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
