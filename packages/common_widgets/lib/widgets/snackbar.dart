import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';

void showSimpleSnackBar(BuildContext context, String message, {TextStyle? style}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: context.colorTheme.primary.withOpacity(0.2),
      content: WrappedText(
        message,
        style: style ?? context.textTheme.titleMedium?.copyWith(color: Colors.white),
      ),
    ),
  );
}
