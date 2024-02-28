import 'package:intl/intl.dart' as intl;

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

  @override
  String get noKeywords => 'No keywords have been added.';

  @override
  String noReviews(Object name) {
    return 'We don\'t have any reviews for $name.';
  }

  @override
  String noCastPresent(Object name) {
    return 'We don\'t have any casts for $name.';
  }

  @override
  String noRecommendation(Object name) {
    return 'We don\'t have enough data to suggest any movies based on $name. You can help by rating movies you\'ve seen.';
  }

  @override
  String get noVideos => 'No Videos have been present.';

  @override
  String get noBackdrops => 'No Backdrops have been present.';

  @override
  String get noPosters => 'No Posters have been present';

  @override
  String get facts => 'Facts';

  @override
  String get network => 'Network';

  @override
  String get type => 'Type';

  @override
  String season(Object number) {
    return 'Season $number';
  }

  @override
  String get seriesCast => 'Series Cast';

  @override
  String seriesCastNumber(Object total) {
    return 'Series Cast $total';
  }

  @override
  String seriesCrewNumber(Object total) {
    return 'Series Crew $total';
  }

  @override
  String castNumber(Object total) {
    return 'Cast $total';
  }

  @override
  String crewNumber(Object total) {
    return 'Crew $total';
  }

  @override
  String get currentSeason => 'Current Season';

  @override
  String get biography => 'Biography';

  @override
  String get knownFor => 'Known For';

  @override
  String get personalInfo => 'Personal Info';

  @override
  String get knownCredits => 'Known Credits';

  @override
  String get gender => 'Gender';

  @override
  String get birthday => 'Birthday';

  @override
  String get placeOfBirth => 'Place of Birth';

  @override
  String get alsoKnownAs => 'Also Known As';

  @override
  String get acting => 'Acting';

  @override
  String yearOld(Object year) {
    return '$year years old';
  }

  @override
  String asCharacter(Object name) {
    return 'as $name';
  }

  @override
  String episodeMapping(Object episode) {
    return '($episode Episodes) ';
  }

  @override
  String get noNetworkForTvSeriesAvailable => 'Not network for tv series available';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get search => 'Search';

  @override
  String tvShowsCount(Object count) {
    return 'TV Shows ($count)';
  }

  @override
  String moviesCount(Object count) {
    return 'Movies ($count)';
  }

  @override
  String peopleCount(Object count) {
    return 'People ($count)';
  }

  @override
  String collectionsCount(Object count) {
    return 'Collections ($count)';
  }

  @override
  String keywordsCount(Object count) {
    return 'Keywords ($count)';
  }

  @override
  String networksCount(Object count) {
    return 'Networks ($count)';
  }

  @override
  String companiesCount(Object count) {
    return 'Companies ($count)';
  }

  @override
  String get companies => 'Companies';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get searchFor => 'Search for a movie, tv show, person...';

  @override
  String actionFor(Object knownFor, Object name) {
    return '$knownFor. $name';
  }

  @override
  String get country => 'Country';

  @override
  String get language => 'Language';

  @override
  String get isAdultIncluded => 'Adult Content Included';

  @override
  String noDataPresentForType(Object mediaName, Object type) {
    return 'No $type Data Present for the $mediaName';
  }

  @override
  String noSearchResultFound(Object type) {
    return 'No \$$type Search Result Found';
  }

  @override
  String get pleaseEnterBeginQuery => 'Please enter a query to begin your search';

  @override
  String get userScore => 'User Score';

  @override
  String get almostIdentical => 'Almost Identical';

  @override
  String seasonOfMessage(Object date, Object num, Object seasonName) {
    return 'Season $num of $seasonName premiered on $date';
  }

  @override
  String totalVotes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count votes',
      one: '1 vote',
    );
    return '$_temp0';
  }

  @override
  String hello(Object name) {
    return 'Hello, \n$name';
  }
}
