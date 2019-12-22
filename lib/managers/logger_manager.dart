import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:logging/logging.dart';
import 'package:intl/intl.dart' show DateFormat;

class LoggerManager {
  static const int wrapLimit = 1024;

  Logger _logger;
  final DateFormat _dateFormatter = new DateFormat("H:m:s.S");

  final String appName;
  final bool debugMode;
  final bool verbose;
  final bool forceLogging;

  LoggerManager({this.appName = "my_app", this.debugMode = true, this.verbose = false, this.forceLogging = false}) {
    Logger.root.level = Level.ALL;

    if (debugMode || forceLogging) {
      Logger.root.onRecord.listen(verbose ? _verboseRecordHandler  : _recordHandler);
    }

    _logger = new Logger(appName);
  }

  void _recordHandler(LogRecord rec) {
    final output = '${rec.level.name} (${_dateFormatter.format(rec.time)}): ${rec.message}';

    if (output.length < wrapLimit) {
      print(output);
    }
    else {
      debugPrint(output, wrapWidth: wrapLimit);
    }

    _errorHandler(rec);
  }

  void _verboseRecordHandler(LogRecord rec) {
    // for better response time, do it async (since the onRecord stream is sync)
    new Future(() {
      print("${rec.time}:${rec.loggerName}:${rec.sequenceNumber}\n"
          "${rec.level}: ${rec.message}");

      _errorHandler(rec);
    });
  }

  void _errorHandler(LogRecord rec) {
    if (rec.error != null) {
      print("Cause: ${rec.error}");
    }

    if (rec.stackTrace != null) {
      print("${rec.stackTrace}");
    }
  }

  /// Log message at level [Level.FINEST].
  void finest(message, [Object error, StackTrace stackTrace]) =>
      _logger.finest(message, error, stackTrace);

  /// Log message at level [Level.FINER].
  void finer(message, [Object error, StackTrace stackTrace]) =>
      _logger.finer(message, error, stackTrace);

  /// Log message at level [Level.FINE].
  void fine(message, [Object error, StackTrace stackTrace]) =>
      _logger.fine(message, error, stackTrace);

  /// Log message at level [Level.CONFIG].
  void config(message, [Object error, StackTrace stackTrace]) =>
      _logger.config(message, error, stackTrace);

  /// Log message at level [Level.INFO].
  void info(message, [Object error, StackTrace stackTrace]) =>
      _logger.info(message, error, stackTrace);

  /// Log message at level [Level.WARNING].
  void warning(message, [Object error, StackTrace stackTrace]) =>
      _logger.warning(message, error, stackTrace);

  /// Log message at level [Level.SEVERE].
  void error(message, [Object error, StackTrace stackTrace]) =>
      _logger.severe(message, error, stackTrace);

  /// Log message at level [Level.SEVERE].
  void severe(message, [Object error, StackTrace stackTrace]) =>
      _logger.severe(message, error, stackTrace);

  /// Log message at level [Level.SHOUT].
  void shout(message, [Object error, StackTrace stackTrace]) =>
      _logger.shout(message, error, stackTrace);
}
