import "package:common_widgets/theme/app_colors.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.dark(useMaterial3: true).copyWith(brightness: Brightness.dark).textTheme,
  ),
);

final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.light(useMaterial3: true).copyWith(brightness: Brightness.light).textTheme,
  ),
);

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  ColorScheme get colorTheme {
    return Theme.of(this).colorScheme;
  }
}
