import "package:common_widgets/localizations/app_localizations.dart";
import "package:flutter/material.dart";

extension Localization on BuildContext {
  AppLocalizations get tr {
    return AppLocalizations.of(this)!;
  }
}
