import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/youtube/youtube_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

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
      child: pos == 0 ? _TmdbVideos() : ((pos == 1) ? _TmdbBackdrops() : _TmdbPosters()),
    );
  }
}

class _TmdbVideos extends StatelessWidget {
  final imageUrls = ["6TGg0_xtLoA", "8fTfj5pWU7Y", "B4JVbM"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageUrls.length,
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
                image: YoutubeThumbnail.hd(imageUrls[index]),
                width: 533,
                height: 300,
                duration: 500,
                curve: Curves.easeIn,
                fitAndroidIos: BoxFit.cover,
                fitWeb: BoxFitWeb.cover,
                onLoading: CircularProgressIndicator(
                  color: context.colorTheme.primary,
                ),
                onError: Center(
                  child: Text(
                    "Failed to load image",
                    style: context.textTheme.titleMedium,
                  ),
                ),
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
          ),
        );
      },
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (imageUrls.length - 1)) {
      return BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }

    return BorderRadius.zero;
  }
}

class _TmdbBackdrops extends StatelessWidget {
  final imageUrls = ["8fTfj5pWU7Y"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageUrls.length,
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
                image: YoutubeThumbnail.hd(imageUrls[index]),
                width: 533,
                height: 300,
                duration: 500,
                curve: Curves.easeIn,
                fitAndroidIos: BoxFit.cover,
                fitWeb: BoxFitWeb.cover,
                onLoading: CircularProgressIndicator(
                  color: context.colorTheme.primary,
                ),
                onError: Center(
                  child: Text(
                    "Failed to load image",
                    style: context.textTheme.titleMedium,
                  ),
                ),
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
          ),
        );
      },
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (imageUrls.length - 1)) {
      return BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }

    return BorderRadius.zero;
  }
}

class _TmdbPosters extends StatelessWidget {
  final imageUrls = ["6TGg0_xtLoA", "8fTfj5pWU7Y"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageUrls.length,
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
                image: YoutubeThumbnail.hd(imageUrls[index]),
                width: 533,
                height: 300,
                duration: 500,
                curve: Curves.easeIn,
                fitAndroidIos: BoxFit.cover,
                fitWeb: BoxFitWeb.cover,
                onLoading: CircularProgressIndicator(
                  color: context.colorTheme.primary,
                ),
                onError: Center(
                  child: Text(
                    "Failed to load image",
                    style: context.textTheme.titleMedium,
                  ),
                ),
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
          ),
        );
      },
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    }

    if (index == (imageUrls.length - 1)) {
      return BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }

    return BorderRadius.zero;
  }
}
