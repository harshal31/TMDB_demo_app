import "package:flutter/material.dart";

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  ColorScheme get colorTheme {
    return Theme.of(this).colorScheme;
  }
}
