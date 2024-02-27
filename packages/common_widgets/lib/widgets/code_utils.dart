import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

String generateUniqueKey() {
  return UniqueKey().toString();
}

bool isTabWeb(BuildContext context) =>
    ResponsiveBreakpoints.of(context).isTablet || ResponsiveBreakpoints.of(context).isDesktop;
