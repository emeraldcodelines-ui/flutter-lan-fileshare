import 'package:flutter/foundation.dart';

/// A service that collects logs from the web server and provides them to the UI.
///
/// This class extends [ChangeNotifier] to notify listeners when logs are added or cleared.
class LogService extends ChangeNotifier {
  // Singleton instance
  factory LogService() => _instance;
  LogService._internal();
  static final LogService _instance = LogService._internal();

  // Private list of logs, each log is a map with 'timestamp' and 'message'
  final List<Map<String, dynamic>> _logs = [];

  /// Returns a copy of the logs sorted by timestamp descending (newest first).
  List<Map<String, dynamic>> get logs {
    final logsCopy = List<Map<String, dynamic>>.from(_logs);
    logsCopy.sort((a, b) => (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime));
    return logsCopy;
  }

  /// Adds a new log entry with the current timestamp.
  /// Limits the list to the last 1000 entries.
  void addLog(String message) {
    _logs.add({
      'timestamp': DateTime.now(),
      'message': message,
    });
    if (_logs.length > 1000) {
      _logs.removeRange(0, _logs.length - 1000);
    }
    notifyListeners();
  }

  /// Clears all logs.
  void clearLogs() {
    _logs.clear();
    notifyListeners();
  }
}
