import 'package:flutter/material.dart';
import 'services/settings_service.dart';
import 'pages/web_server_page.dart';

void main() {
  runApp(const FlutterLanFileShareApp());
}

class FlutterLanFileShareApp extends StatefulWidget {
  const FlutterLanFileShareApp({super.key});

  @override
  State<FlutterLanFileShareApp> createState() => _FlutterLanFileShareAppState();
}

class _FlutterLanFileShareAppState extends State<FlutterLanFileShareApp> {
  final SettingsService _settings = SettingsService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await _settings.loadSettings();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show a simple loading screen while settings load
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return ListenableBuilder(
      listenable: _settings,
      builder: (context, child) {
        return MaterialApp(
          title: 'LAN File Share',
          theme: ThemeData.light().copyWith(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark().copyWith(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          themeMode: _settings.themeModeEnum,
          home: const WebServerPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
