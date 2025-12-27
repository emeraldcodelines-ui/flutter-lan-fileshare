import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends ChangeNotifier {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  static const String _portKey = 'server_port';
  static const String _sharedDirKey = 'shared_directory';
  static const String _themeModeKey = 'theme_mode';

  int _port = 8080;
  String _sharedDir = '';
  String _themeMode = 'system';

  int get port => _port;
  String get sharedDir => _sharedDir;
  String get themeMode => _themeMode;

  ThemeMode get themeModeEnum {
    switch (_themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _port = prefs.getInt(_portKey) ?? 8080;
    _sharedDir = prefs.getString(_sharedDirKey) ?? '';
    _themeMode = prefs.getString(_themeModeKey) ?? 'system';
    notifyListeners();
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

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_portKey);
    await prefs.remove(_sharedDirKey);
    await prefs.remove(_themeModeKey);
    _port = 8080;
    _sharedDir = '';
    _themeMode = 'system';
    notifyListeners();
  }
}
