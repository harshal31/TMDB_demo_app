import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/theme/theme_util.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:common_widgets/youtube/youtube_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';
import 'package:tmdb_app/routes/route_name.dart';

class TmdbVideosListing extends StatelessWidget {
  final Map<String, List<Videos>> map;
  final double imageWidth;
  final double? imageHeight;
  final String mediaId;
  final bool isMovies;

  const TmdbVideosListing({
    super.key,
    required this.map,
    required this.imageWidth,
    required this.mediaId,
    required this.isMovies,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: map.length,
      shrinkWrap: true,
      itemBuilder: (ctx, outer) {
        final values = map[map.keys.toList()[outer]] ?? [];
        return Column(
          key: ValueKey(outer),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WrappedText(
              map.keys.toList()[outer],
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: values.length,
              separatorBuilder: (_, ind) => const SizedBox(height: 16),
              itemBuilder: (ctx, inner) {
                return TmdbVideosListingItem(
                  key: UniqueKey(),
                  video: values[inner],
                  imageWidth: imageWidth,
                  mediaId: mediaId,
                  isMovies: isMovies,
                  imageHeight: imageHeight ?? 200,
                );
              },
            ),
            const SizedBox(height: 22),
          ],
        );
      },
    );
  }
}

class TmdbVideosListingItem extends StatelessWidget {
  final Videos video;
  final double imageWidth;
  final double imageHeight;
  final String mediaId;
  final bool isMovies;

  const TmdbVideosListingItem({
    super.key,
    required this.video,
    required this.imageWidth,
    required this.mediaId,
    required this.isMovies,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Card(
              margin: EdgeInsets.zero,
              surfaceTintColor: context.colorTheme.background,
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: context.colorTheme.onBackground.withOpacity(0.4), // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: imageWidth,
                      height: imageHeight,
                      child: Stack(
                        children: [
                          ImageNetwork(
                            image: YoutubeThumbnail.mq(video.key),
                            width: imageWidth,
                            height: imageHeight,
                            borderRadius: BorderRadius.circular(10),
                            curve: Curves.easeIn,
                          ),
                          Center(
                            child: Icon(
                              Icons.play_circle,
                              size: imageHeight / 3,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          WrappedText(
                            video.name ?? "",
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          WrappedText(
                            video.publishedAt.formatDateInMMMMFormat,
                            style: context.textTheme.titleSmall,
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
                    "${RouteName.home}/${isMovies ? ApiKey.movie : ApiKey.tv}/$mediaId/${RouteName.videos}/${RouteName.youtubeVideo}/${video.key}",
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
