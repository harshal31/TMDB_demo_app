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
}
