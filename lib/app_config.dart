import 'package:flutter/foundation.dart';

import 'managers/logger_manager.dart';

// app info
const String appName = "sight_word_helper";
const String ver = "0.0.1";
final bool debugMode = !kReleaseMode;

// create logger
LoggerManager _log = LoggerManager(appName: appName, debugMode: debugMode);
LoggerManager get log => _log;
