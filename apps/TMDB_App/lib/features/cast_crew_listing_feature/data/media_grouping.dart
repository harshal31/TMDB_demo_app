import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
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

class GroupBackdrops with EquatableMixin {
  final Map<String, List<Backdrops>> groupBackdrops;
  final Map<String, List<Backdrops>> currentGroupBackdrops;

  GroupBackdrops({
    required this.groupBackdrops,
    required this.currentGroupBackdrops,
  });

  factory GroupBackdrops.initial() {
    return GroupBackdrops(
      groupBackdrops: {},
      currentGroupBackdrops: {},
    );
  }

  GroupBackdrops copyWith({
    Map<String, List<Backdrops>>? groupBackdrops,
    Map<String, List<Backdrops>>? currentGroupBackdrops,
  }) {
    return GroupBackdrops(
      groupBackdrops: groupBackdrops ?? this.groupBackdrops,
      currentGroupBackdrops: currentGroupBackdrops ?? this.currentGroupBackdrops,
    );
  }

  Map<String, List<Backdrops>> getBackdropsBasedOnProvidedType(String type) {
    this.currentGroupBackdrops.clear();
    return {
      type: this.groupBackdrops[type] ?? [],
    };
  }

  @override
  List<Object?> get props => [
        groupBackdrops,
        currentGroupBackdrops,
      ];
}

class GroupPosters with EquatableMixin {
  final Map<String, List<Posters>> groupPosters;
  final Map<String, List<Posters>> currentGroupPosters;

  GroupPosters({
    required this.groupPosters,
    required this.currentGroupPosters,
  });

  factory GroupPosters.initial() {
    return GroupPosters(
      groupPosters: {},
      currentGroupPosters: {},
    );
  }

  GroupPosters copyWith({
    Map<String, List<Posters>>? groupPosters,
    Map<String, List<Posters>>? currentGroupPosters,
  }) {
    return GroupPosters(
      groupPosters: groupPosters ?? this.groupPosters,
      currentGroupPosters: currentGroupPosters ?? this.currentGroupPosters,
    );
  }

  Map<String, List<Posters>> getPostersBasedOnProvidedType(String type) {
    this.currentGroupPosters.clear();
    return {
      type: this.groupPosters[type] ?? [],
    };
  }

  @override
  List<Object?> get props => [
        groupPosters,
        currentGroupPosters,
      ];
}
