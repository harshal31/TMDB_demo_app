import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:common_widgets/youtube/youtube_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';
import 'package:tmdb_app/routes/route_name.dart';

class TmdbMediaView extends StatelessWidget {
  final int pos;
  final String mediaId;
  final List<Videos> videos;
  final MediaImages? images;
  final String? mediaType;
  final double? height;
  final double? width;

  const TmdbMediaView({
    super.key,
    required this.pos,
    required this.videos,
    required this.images,
    required this.mediaId,
    this.height,
    this.width,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 300,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: pos == 0
          ? _TmdbVideos(
              videos: videos.take(10).toList(),
              mediaId: mediaId,
              height: height,
              width: width,
              mediaType: mediaType,
            )
          : ((pos == 1)
              ? _TmdbBackdrops(
                  backDrops: images?.backdrops?.take(10).toList() ?? [],
                  height: height,
                  width: width,
                )
              : _TmdbPosters(
                  posters: images?.posters?.take(10).toList() ?? [],
                  height: height,
                )),
    );
  }
}

class _TmdbVideos extends StatelessWidget {
  final List<Videos> videos;
  final String mediaId;
  final double? height;
  final double? width;
  final String? mediaType;

  const _TmdbVideos({
    required this.videos,
    required this.mediaId,
    this.height,
    this.width,
    this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: videos.isNotEmpty,
      child: ListView.builder(
        itemCount: videos.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Container(
            key: ValueKey(index),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: _getBorderRadius(index),
            ),
            child: Stack(
              children: [
                ImageNetwork(
                  image: YoutubeThumbnail.hd(videos[index].key),
                  width: width ?? 533,
                  height: height ?? 300,
                  duration: 400,
                  fitAndroidIos: BoxFit.cover,
                  borderRadius: _getBorderRadius(index),
                  curve: Curves.easeIn,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width ?? 533,
                    height: height ?? 300,
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.play_circle_outline_sharp,
                        size: 40,
                        color: context.colorTheme.primaryContainer,
                      ),
                      onPressed: () {
                        context.push(
                          "${RouteName.home}/$mediaType/$mediaId/${RouteName.youtubeVideo}/${videos[index].key}/",
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      replacement: Center(
        child: WrappedText(
          context.tr.noVideos,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (videos.length - 1)) {
      return const BorderRadius.only(
          topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }

    return BorderRadius.zero;
  }
}

class _TmdbBackdrops extends StatelessWidget {
  final List<Backdrops> backDrops;
  final double? height;
  final double? width;

  const _TmdbBackdrops({
    required this.backDrops,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: backDrops.isNotEmpty,
      child: ListView.builder(
        itemCount: backDrops.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return ExtendedImageCreator(
            key: ValueKey(index),
            imageUrl: backDrops[index].getImage(),
            width: width ?? 533,
            height: height ?? 300,
            fit: BoxFit.cover,
            borderRadius: _getBorderRadius(index),
          );
        },
      ),
      replacement: Center(
        child: WrappedText(
          context.tr.noBackdrops,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (backDrops.length - 1)) {
      return const BorderRadius.only(
          topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }

    return BorderRadius.zero;
  }
}

class _TmdbPosters extends StatelessWidget {
  final List<Posters> posters;
  final double? height;

  const _TmdbPosters({required this.posters, this.height});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: posters.isNotEmpty,
      child: ListView.builder(
        itemCount: posters.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return ExtendedImageCreator(
            key: ValueKey(index),
            imageUrl: posters[index].getImage(),
            width: 160,
            height: height ?? 300,
            fit: BoxFit.cover,
            borderRadius: _getBorderRadius(index),
          );
        },
      ),
      replacement: Center(
        child: WrappedText(
          context.tr.noPosters,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (posters.length - 1)) {
      return const BorderRadius.only(
          topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }

    return BorderRadius.zero;
  }
}
