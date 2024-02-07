import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

extension BuildExtensions on BuildContext {
  TextStyle? get dynamicTextStyle {
    return this.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
  }

  BoxDecoration get boxDecoration {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          this.colorTheme.primary.withOpacity(0.4),
          this.colorTheme.primary.withOpacity(0.1),
        ],
      ),
    );
  }
}
