import 'package:flutter/material.dart';
import 'pages/web_server_page.dart';

void main() {
  runApp(const FlutterLanFileShareApp());
}

class FlutterLanFileShareApp extends StatelessWidget {
  const FlutterLanFileShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAN File Share',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WebServerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// A simple Flutter Windows app for sharing files over Wi-Fi/LAN using lan_web_server.