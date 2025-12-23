import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  static const String _portKey = 'server_port';
  static const String _sharedDirKey = 'shared_directory';

  int _port = 8080;
  String _sharedDir = '';

  int get port => _port;
  String get sharedDir => _sharedDir;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _port = prefs.getInt(_portKey) ?? 8080;
    _sharedDir = prefs.getString(_sharedDirKey) ?? '';
  }

  Future<void> savePort(int port) async {
    if (port < 1 || port > 65535) {
      throw ArgumentError('Port must be between 1 and 65535');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_portKey, port);
    _port = port;
  }

  Future<void> saveSharedDir(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sharedDirKey, path);
    _sharedDir = path;
  }

  Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_portKey);
    await prefs.remove(_sharedDirKey);
    _port = 8080;
    _sharedDir = '';
  }
}
