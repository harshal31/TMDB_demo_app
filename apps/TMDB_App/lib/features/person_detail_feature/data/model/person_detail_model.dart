import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:common_widgets/common_utils/date_util.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/app_constant.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_credit.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_detail.dart';

class PersonDetailModel {
  final PersonDetail? personDetail;
  final List<PersonCrew>? crews;
  final List<PersonCast>? casts;
  final MediaExternalId? tmdbShare;
  final Map<int, List<PersonCrew>> mapping;

  PersonDetailModel(
      {this.personDetail, this.crews, this.casts, this.tmdbShare, required this.mapping});

  PersonDetailModel copyWith({
    PersonDetail? personDetail,
    List<PersonCrew>? crews,
    List<PersonCast>? casts,
    MediaExternalId? tmdbShare,
    Map<int, List<PersonCrew>>? mapping,
  }) {
    return PersonDetailModel(
      personDetail: personDetail ?? this.personDetail,
      crews: crews ?? this.crews,
      casts: casts ?? this.casts,
      tmdbShare: tmdbShare ?? this.tmdbShare,
      mapping: mapping ?? this.mapping,
    );
  }

  List<PersonCrew> transformCast() {
    return this
            .casts
            ?.map(
              (e) => PersonCrew(
                adult: e.adult,
                backdropPath: e.backdropPath,
                genreIds: e.genreIds,
                id: e.id,
                originalLanguage: e.originalLanguage,
                originalTitle: e.originalTitle ?? e.originalName ?? e.title ?? e.name,
                overview: e.overview,
                popularity: e.popularity,
                posterPath: e.posterPath,
                releaseDate: e.releaseDate ?? e.firstAirDate ?? "",
                title: e.title,
                video: e.video,
                voteAverage: e.voteAverage,
                voteCount: e.voteCount,
                creditId: e.creditId,
                department: "Acting",
                job: e.character ?? "",
                mediaType: e.mediaType,
                originCountry: e.originCountry,
                originalName: e.originalName,
                firstAirDate: e.firstAirDate,
                name: e.name,
                episodeCount: e.episodeCount,
              ),
            )
            .toList() ??
        [];
  }

  bool isPersonDetailFetchFailed() {
    return this.personDetail == null || (this.crews == null && this.casts == null);
  }

  Map<int, List<PersonCrew>> getMapping() {
    int i = -1;
    final resMap = SplayTreeMap.of(
      [...?this.crews, ...transformCast()]
          .map((e) => e.copyWith(
              originalTitle: e.originalTitle ?? e.originalName ?? e.title ?? e.name, job: e.job))
          .sortWith(
            (e) => e.releaseDate.getDateTime?.year ?? (DateTime.now().year + 1),
            Order.orderInt.reverse,
          )
          .groupListsBy((e) => e.department),
    );

    return Map.of(
      resMap.map(
        (key, value) {
          ++i;
          return MapEntry(i, value);
        },
      ),
    );
  }

  String get profilePathImageUrl {
    return AppConstant.originalImageBaseUrl + (this.personDetail?.profilePath ?? "");
  }
}
