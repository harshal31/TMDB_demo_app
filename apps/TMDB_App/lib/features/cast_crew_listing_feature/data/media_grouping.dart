import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';

class GroupVideos with EquatableMixin {
  final Map<String, List<Videos>> groupVideos;
  final Map<String, List<Videos>> currentGroupVideos;

  GroupVideos({
    required this.groupVideos,
    required this.currentGroupVideos,
  });

  factory GroupVideos.initial() {
    return GroupVideos(
      groupVideos: {},
      currentGroupVideos: {},
    );
  }

  GroupVideos copyWith({
    Map<String, List<Videos>>? groupVideos,
    Map<String, List<Videos>>? currentGroupVideos,
  }) {
    return GroupVideos(
      groupVideos: groupVideos ?? this.groupVideos,
      currentGroupVideos: currentGroupVideos ?? this.currentGroupVideos,
    );
  }

  Map<String, List<Videos>> getVideosBasedOnProvidedType(String type) {
    return {
      type: groupVideos[type] ?? [],
    };
  }

  @override
  List<Object?> get props => [
        groupVideos,
        currentGroupVideos,
      ];
}
