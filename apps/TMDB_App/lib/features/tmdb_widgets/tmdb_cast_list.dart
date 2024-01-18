import 'package:common_widgets/theme/app_theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TmdbCastList extends StatelessWidget {
  final List<TmdbCastModel> models;
  final double? height;
  final double? width;
  final Function()? onViewAllClick;
  final Function(int)? onItemClick;

  const TmdbCastList({
    super.key,
    required this.models,
    this.height,
    this.width,
    this.onViewAllClick,
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 245,
      child: ListView.builder(
        itemCount: models.length + 1,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          if (index == models.length) {
            return Container(
              key: ValueKey(index),
              alignment: Alignment.center,
              width: width ?? 175,
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
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: width ?? 175,
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
                        models[index].imageUrl,
                        width: width ?? 175,
                        height: 138,
                        fit: BoxFit.fill,
                        cache: true,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        cacheMaxAge: Duration(days: 2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Expanded(
                          child: Text(
                            models[index].actorName,
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
                            models[index].actorName,
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

class TmdbCastModel {
  final String imageUrl;
  final String actorName;
  final String characterName;

  TmdbCastModel({
    required this.imageUrl,
    required this.actorName,
    required this.characterName,
  });
}

final tmdbModelList = [
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
  TmdbCastModel(
    imageUrl: "https://image.tmdb.org/t/p/w500/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg",
    actorName: "Brian Lara sakbdkjas jkabkjd",
    characterName: "Hemant sajbdkbsakd akbdkjsabk",
  ),
];
