import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/youtube/youtube_thumbnail.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

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
    this.mediaType,
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
              videos: videos,
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
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Container(
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
                  fullScreen: false,
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
                        context.goNamed(
                          (this.mediaType == ApiKey.movie
                              ? RouteName.youtubeVideo
                              : RouteName.tvSeriesYoutubeVideo),
                          pathParameters: {
                            RouteParam.videoId: videos[index].key ?? "",
                            RouteParam.id: mediaId
                          },
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
        child: Text(
          context.tr.noVideos,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (videos.length - 1)) {
      return BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15));
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
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return ExtendedImage.network(
            backDrops[index].getImage(),
            width: width ?? 533,
            height: height ?? 300,
            fit: BoxFit.cover,
            cache: true,
            shape: BoxShape.rectangle,
            borderRadius: _getBorderRadius(index),
            cacheMaxAge: Duration(minutes: 30),
          );
        },
      ),
      replacement: Center(
        child: Text(
          context.tr.noBackdrops,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (backDrops.length - 1)) {
      return BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15));
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
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return ExtendedImage.network(
            posters[index].getImage(),
            width: 160,
            height: height ?? 300,
            fit: BoxFit.cover,
            cache: true,
            shape: BoxShape.rectangle,
            borderRadius: _getBorderRadius(index),
            cacheMaxAge: Duration(minutes: 30),
          );
        },
      ),
      replacement: Center(
        child: Text(
          context.tr.noPosters,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (posters.length - 1)) {
      return BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }

    return BorderRadius.zero;
  }
}
