class Logger {
  static const String _tag = 'CubiCasa';

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _log('DEBUG', message, error, stackTrace);
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    _log('INFO', message, error, stackTrace);
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _log('WARNING', message, error, stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log('ERROR', message, error, stackTrace);
  }

  static void _log(String level, String message, Object? error, StackTrace? stackTrace) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '[$timestamp] [$_tag] [$level] $message';
    
    if (error != null) {
      print('$logMessage\nError: $error');
    }
    if (stackTrace != null) {
      print('StackTrace: $stackTrace');
    }
    if (error == null && stackTrace == null) {
      print(logMessage);
    }
  }
}
