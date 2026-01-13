import 'package:logger/logger.dart';

/// Multi logger wrapper for logger
class MultiLogger extends Logger {
  final List<Logger> loggers;

  MultiLogger(
    /// create logger list
    List<Logger Function(LogFilter? filter, Level? level)> create, {
    super.filter,
    super.level,
  }) : loggers = create.map((c) => c(filter, level)).toList();

  @override
  void log(
    Level level,
    message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    for (final inst in loggers) {
      inst.log(
        level,
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static MultiLogger? instance;

  static void initialize(MultiLogger logger) {
    instance = logger;
  }
}

MultiLogger? get logger => MultiLogger.instance;
