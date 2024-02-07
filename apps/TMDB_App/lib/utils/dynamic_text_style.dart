import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

extension BuildExtensions on BuildContext {
  TextStyle? get dynamicTextStyle {
    final value = ResponsiveBreakpoints.of(this);
    if (value.isMobile) {
      return this.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold);
    } else {
      return this.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold);
    }
  }
}
