import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get userName => 'UserName';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign In';

  @override
  String get invalidUserNameMessage => 'Please provide valid Username';

  @override
  String get invalidPasswordMessage => 'Please provide valid Password';

  @override
  String get trending => 'Trending';

  @override
  String get latest => 'Latest';

  @override
  String get all => 'All';

  @override
  String get movies => 'Movies';

  @override
  String get people => 'People';

  @override
  String get tv => 'TV';

  @override
  String get today => 'Today';

  @override
  String get thisWeek => 'This Week';

  @override
  String get tvSeries => 'Tv Series';

  @override
  String get nowPlaying => 'Now Playing';

  @override
  String get popular => 'Popular';

  @override
  String get topRated => 'Top Rated';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get airingToday => 'Airing Today';

  @override
  String get onTheAir => 'On The Air';

  @override
  String get freeToWatch => 'Free To Watch';

  @override
  String get markAsFavorite => 'Mark As Favorite';

  @override
  String get addToWatchlist => 'Add to your watchlist';

  @override
  String get rateIt => 'Rate It!';

  @override
  String get overview => 'Overview';

  @override
  String get topBilledCast => 'Top Billed Cast';

  @override
  String get fullCastCrew => 'Full Cast and Crew';

  @override
  String get status => 'Status';

  @override
  String get originalLanguage => 'Original Language';

  @override
  String get budget => 'Budget';

  @override
  String get revenue => 'Revenue';

  @override
  String get keywords => 'Keywords';

  @override
  String get social => 'Social';

  @override
  String get reviews => 'Reviews';

  @override
  String get readAllReviews => 'Read All Reviews';

  @override
  String get media => 'Media';

  @override
  String get mostPopular => 'Most Popular';

  @override
  String get videos => 'Videos';

  @override
  String get backdrops => 'Backdrops';

  @override
  String get posters => 'Posters';

  @override
  String get recommendations => 'Recommendations';

  @override
  String get readMore => 'Read More';

  @override
  String get readLess => 'Read Less';

  @override
  String writtenBy(Object date, Object user) {
    return 'Written by $user on $date';
  }

  @override
  String aReviewBy(Object user) {
    return 'A Review By $user';
  }
}
