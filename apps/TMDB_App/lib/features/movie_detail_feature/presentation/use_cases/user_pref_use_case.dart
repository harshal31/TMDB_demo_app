import 'package:tmdb_app/features/movie_detail_feature/data/media_detail_api_service.dart';

class UserPrefUseCase {
  final MediaDetailApiService _movieDetailApiService;

  UserPrefUseCase(this._movieDetailApiService);

  void saveUserPref(
    String sessionId,
    String mediaType,
    int mediaId,
    String userKey,
    bool prefValue,
  ) async {
    final map = {
      "media_type": "$mediaType",
      "media_id": mediaId,
      "$userKey": prefValue,
    };

    await _movieDetailApiService.saveUserPref(userKey, sessionId, map);
  }

  void addRating(String sessionId, String mediaType, double rating, int mediaId) async {
    final map = {"value": rating};
    await _movieDetailApiService.addMediaRating(mediaType, mediaId, sessionId, map);
  }
}
