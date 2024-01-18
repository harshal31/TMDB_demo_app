///Class for returning a thumbnail of a youtube video
class YoutubeThumbnail {
  ///Return (maxresdefault) image as size of 1280x720
  static String hd(String? _id) {
    return 'https://img.youtube.com/vi/$_id/hqdefault.jpg';
  }

  ///Return (sddefault) image as size of 640x480
  static String standard(String? _id) {
    return 'https://img.youtube.com/vi/$_id/sddefault.jpg';
  }

  ///Return (hqdefault) image as size of 480x360
  static String hq(String? _id) {
    return 'https://img.youtube.com/vi/$_id/hqdefault.jpg';
  }

  ///Return (mqdefault) image as size of 320x180
  static String mq(String? _id) {
    return 'https://img.youtube.com/vi/$_id/mqdefault.jpg';
  }

  //Return (default) image as size of 120x90
  static String small(String? _id) {
    return 'https://img.youtube.com/vi/$_id/default.jpg';
  }
}
