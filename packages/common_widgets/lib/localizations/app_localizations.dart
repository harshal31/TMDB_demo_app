import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localizations/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'UserName'**
  String get userName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @invalidUserNameMessage.
  ///
  /// In en, this message translates to:
  /// **'Please provide valid Username'**
  String get invalidUserNameMessage;

  /// No description provided for @invalidPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Please provide valid Password'**
  String get invalidPasswordMessage;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @latest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latest;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

  /// No description provided for @people.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get people;

  /// No description provided for @tv.
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get tv;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @tvSeries.
  ///
  /// In en, this message translates to:
  /// **'Tv Series'**
  String get tvSeries;

  /// No description provided for @nowPlaying.
  ///
  /// In en, this message translates to:
  /// **'Now Playing'**
  String get nowPlaying;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @topRated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get topRated;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @airingToday.
  ///
  /// In en, this message translates to:
  /// **'Airing Today'**
  String get airingToday;

  /// No description provided for @onTheAir.
  ///
  /// In en, this message translates to:
  /// **'On The Air'**
  String get onTheAir;

  /// No description provided for @freeToWatch.
  ///
  /// In en, this message translates to:
  /// **'Free To Watch'**
  String get freeToWatch;

  /// No description provided for @markAsFavorite.
  ///
  /// In en, this message translates to:
  /// **'Mark As Favorite'**
  String get markAsFavorite;

  /// No description provided for @addToWatchlist.
  ///
  /// In en, this message translates to:
  /// **'Add to your watchlist'**
  String get addToWatchlist;

  /// No description provided for @rateIt.
  ///
  /// In en, this message translates to:
  /// **'Rate It!'**
  String get rateIt;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @topBilledCast.
  ///
  /// In en, this message translates to:
  /// **'Top Billed Cast'**
  String get topBilledCast;

  /// No description provided for @fullCastCrew.
  ///
  /// In en, this message translates to:
  /// **'Full Cast and Crew'**
  String get fullCastCrew;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @originalLanguage.
  ///
  /// In en, this message translates to:
  /// **'Original Language'**
  String get originalLanguage;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @keywords.
  ///
  /// In en, this message translates to:
  /// **'Keywords'**
  String get keywords;

  /// No description provided for @social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get social;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @readAllReviews.
  ///
  /// In en, this message translates to:
  /// **'Read All Reviews'**
  String get readAllReviews;

  /// No description provided for @media.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get media;

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get mostPopular;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @backdrops.
  ///
  /// In en, this message translates to:
  /// **'Backdrops'**
  String get backdrops;

  /// No description provided for @posters.
  ///
  /// In en, this message translates to:
  /// **'Posters'**
  String get posters;

  /// No description provided for @recommendations.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get recommendations;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get readLess;

  /// No description provided for @writtenBy.
  ///
  /// In en, this message translates to:
  /// **'Written by {user} on {date}'**
  String writtenBy(Object date, Object user);

  /// No description provided for @aReviewBy.
  ///
  /// In en, this message translates to:
  /// **'A Review By {user}'**
  String aReviewBy(Object user);

  /// No description provided for @noKeywords.
  ///
  /// In en, this message translates to:
  /// **'No keywords have been added.'**
  String get noKeywords;

  /// No description provided for @noReviews.
  ///
  /// In en, this message translates to:
  /// **'We don\'t have any reviews for {name}.'**
  String noReviews(Object name);

  /// No description provided for @noRecommendation.
  ///
  /// In en, this message translates to:
  /// **'We don\'t have enough data to suggest any movies based on {name}. You can help by rating movies you\'ve seen.'**
  String noRecommendation(Object name);

  /// No description provided for @noVideos.
  ///
  /// In en, this message translates to:
  /// **'No Videos have been present.'**
  String get noVideos;

  /// No description provided for @noBackdrops.
  ///
  /// In en, this message translates to:
  /// **'No Backdrops have been present.'**
  String get noBackdrops;

  /// No description provided for @noPosters.
  ///
  /// In en, this message translates to:
  /// **'No Posters have been present'**
  String get noPosters;

  /// No description provided for @facts.
  ///
  /// In en, this message translates to:
  /// **'Facts'**
  String get facts;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @season.
  ///
  /// In en, this message translates to:
  /// **'Season {number}'**
  String season(Object number);

  /// No description provided for @seriesCast.
  ///
  /// In en, this message translates to:
  /// **'Series Cast'**
  String get seriesCast;

  /// No description provided for @currentSeason.
  ///
  /// In en, this message translates to:
  /// **'Current Season'**
  String get currentSeason;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get biography;

  /// No description provided for @knownFor.
  ///
  /// In en, this message translates to:
  /// **'Known For'**
  String get knownFor;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// No description provided for @knownCredits.
  ///
  /// In en, this message translates to:
  /// **'Known Credits'**
  String get knownCredits;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @placeOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Place of Birth'**
  String get placeOfBirth;

  /// No description provided for @alsoKnownAs.
  ///
  /// In en, this message translates to:
  /// **'Also Known As'**
  String get alsoKnownAs;

  /// No description provided for @acting.
  ///
  /// In en, this message translates to:
  /// **'Acting'**
  String get acting;

  /// No description provided for @yearOld.
  ///
  /// In en, this message translates to:
  /// **'{year} years old'**
  String yearOld(Object year);

  /// No description provided for @asCharacter.
  ///
  /// In en, this message translates to:
  /// **'as {name}'**
  String asCharacter(Object name);

  /// No description provided for @episodeMapping.
  ///
  /// In en, this message translates to:
  /// **'({episode} Episodes) '**
  String episodeMapping(Object episode);

  /// No description provided for @noNetworkForTvSeriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not network for tv series available'**
  String get noNetworkForTvSeriesAvailable;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @tvShowsCount.
  ///
  /// In en, this message translates to:
  /// **'TV Shows ({count})'**
  String tvShowsCount(Object count);

  /// No description provided for @moviesCount.
  ///
  /// In en, this message translates to:
  /// **'Movies ({count})'**
  String moviesCount(Object count);

  /// No description provided for @peopleCount.
  ///
  /// In en, this message translates to:
  /// **'People ({count})'**
  String peopleCount(Object count);

  /// No description provided for @collectionsCount.
  ///
  /// In en, this message translates to:
  /// **'Collections ({count})'**
  String collectionsCount(Object count);

  /// No description provided for @keywordsCount.
  ///
  /// In en, this message translates to:
  /// **'Keywords ({count})'**
  String keywordsCount(Object count);

  /// No description provided for @networksCount.
  ///
  /// In en, this message translates to:
  /// **'Networks ({count})'**
  String networksCount(Object count);

  /// No description provided for @companiesCount.
  ///
  /// In en, this message translates to:
  /// **'Companies ({count})'**
  String companiesCount(Object count);

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @searchFor.
  ///
  /// In en, this message translates to:
  /// **'Search for a movie, tv show, person...'**
  String get searchFor;

  /// No description provided for @actionFor.
  ///
  /// In en, this message translates to:
  /// **'{knownFor}. {name}'**
  String actionFor(Object knownFor, Object name);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
