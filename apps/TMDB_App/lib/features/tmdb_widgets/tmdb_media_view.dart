import 'package:common_widgets/youtube/youtube_thumbnail.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TmdbMediaView extends StatelessWidget {
  final int pos;

  const TmdbMediaView({
    super.key,
    required this.pos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: _TmdbVideos(),
    );
  }
}

class _TmdbVideos extends StatelessWidget {
  final imageUrls = ["6TGg0_xtLoA", "8fTfj5pWU7Y", "B4JVbM"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        return Stack(
          children: [
            ExtendedImage.network(
              YoutubeThumbnail.hd(imageUrls[index]),
              width: 533,
              height: 300,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 533,
                height: 300,
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle_outline_sharp,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TmdbBackdrops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _TmdbPosters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
