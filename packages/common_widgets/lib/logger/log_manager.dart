import "package:common_widgets/logger/custom_log_filter.dart";
import "package:logger/logger.dart";

class Log {
  static Logger? _logger;

  static void _initializeLogger() {
    if (_logger == null) {
      _logger = Logger(
        filter: CustomLogFilter(),
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 10,
          lineLength: 250,
          printTime: true,
          printEmojis: true,
          colors: true,
        ),
      );
    }
  }

  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _initializeLogger();
    _logger?.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _initializeLogger();
    _logger?.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _initializeLogger();
    _logger?.t(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _initializeLogger();
    _logger?.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _initializeLogger();
    _logger?.e(message, time: time, error: error, stackTrace: stackTrace);
  }
}
