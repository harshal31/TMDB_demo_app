import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:common_widgets/youtube/youtube_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';
import 'package:tmdb_app/routes/route_name.dart';

class TmdbMediaView extends StatelessWidget {
  final int pos;
  final MediaDetail? mediaDetail;
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
    required this.mediaDetail,
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
              mediaId: mediaDetail?.id.toString() ?? "",
              height: height,
              width: width,
              mediaType: mediaType,
            )
          : ((pos == 1)
              ? _TmdbBackdrops(
                  backDrops: images?.backdrops?.take(10).toList() ?? [],
                  height: height,
                  width: width,
                  mediaId: mediaDetail?.id.toString() ?? "",
                  mediaDetail: mediaDetail,
                )
              : _TmdbPosters(
                  posters: images?.posters?.take(10).toList() ?? [],
                  height: height,
                  mediaId: mediaDetail?.id.toString() ?? "",
                  mediaDetail: mediaDetail,
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
      child: ListView.separated(
        itemCount: videos.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Container(
            width: width ?? 533,
            height: height ?? 300,
            key: ValueKey(index),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: width ?? 533,
              height: height ?? 300,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ImageNetwork(
                      image: YoutubeThumbnail.hd(videos[index].key),
                      width: width ?? 533,
                      height: height ?? 300,
                      duration: 400,
                      fitAndroidIos: BoxFit.cover,
                      borderRadius: BorderRadius.circular(10),
                      curve: Curves.easeIn,
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.play_circle,
                      size: (width ?? 300) / 5,
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          context.push(
                            "${RouteName.home}/$mediaType/$mediaId/${RouteName.youtubeVideo}/${videos[index].key}/",
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) => const SizedBox(width: 16),
      ),
      replacement: Center(
        child: WrappedText(
          context.tr.noVideos,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }
}

class _TmdbBackdrops extends StatelessWidget {
  final List<Backdrops> backDrops;
  final MediaDetail? mediaDetail;
  final String mediaId;
  final double? height;
  final double? width;

  const _TmdbBackdrops({
    required this.backDrops,
    required this.mediaDetail,
    this.height,
    this.width,
    required this.mediaId,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: backDrops.isNotEmpty,
      child: ListView.separated(
        itemCount: backDrops.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return SizedBox(
            width: width ?? 533,
            height: height ?? 300,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: ExtendedImageCreator(
                      key: ValueKey(index),
                      imageUrl: backDrops[index].getImage(),
                      width: width ?? 533,
                      height: height ?? 300,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        context.push(
                          "${RouteName.home}/${RouteName.movie}/$mediaId/${RouteName.backdrops}/$index",
                          extra: mediaDetail,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (ctx, index) => const SizedBox(width: 16),
      ),
      replacement: Center(
        child: WrappedText(
          context.tr.noBackdrops,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }
}

class _TmdbPosters extends StatelessWidget {
  final List<Posters> posters;
  final MediaDetail? mediaDetail;
  final String mediaId;
  final double? height;

  const _TmdbPosters({
    required this.posters,
    required this.mediaDetail,
    this.height,
    required this.mediaId,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: posters.isNotEmpty,
      child: ListView.separated(
        itemCount: posters.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return SizedBox(
            width: 160,
            height: height ?? 300,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ExtendedImageCreator(
                    key: ValueKey(index),
                    imageUrl: posters[index].getImage(),
                    width: 160,
                    height: height ?? 300,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        context.push(
                          "${RouteName.home}/${RouteName.movie}/$mediaId/${RouteName.posters}/$index",
                          extra: mediaDetail,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (ctx, index) => const SizedBox(width: 16),
      ),
      replacement: Center(
        child: WrappedText(
          context.tr.noPosters,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }
}
