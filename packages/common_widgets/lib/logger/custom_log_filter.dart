import "package:flutter/foundation.dart";
import "package:logger/logger.dart";

class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return !kReleaseMode;
  }
}