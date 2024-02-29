import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';

class AccountDetailData {
  final LatestResults? favorites;
  final LatestResults? rated;
  final LatestResults? watchList;

  AccountDetailData({
    required this.favorites,
    required this.rated,
    required this.watchList,
  });

  factory AccountDetailData.initial() {
    return AccountDetailData(
      favorites: null,
      rated: null,
      watchList: null,
    );
  }

  AccountDetailData copyWith({
    LatestResults? favorites,
    LatestResults? rated,
    LatestResults? watchList,
  }) {
    return AccountDetailData(
      favorites: favorites ?? this.favorites,
      rated: rated ?? this.rated,
      watchList: watchList ?? this.watchList,
    );
  }
}
