import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideo extends StatefulWidget {
  final String id;

  const YoutubeVideo({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return _YoutubeVideoState();
  }
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.id,
    );
    _controller.playVideo();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}
