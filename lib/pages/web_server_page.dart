// Assuming this is the modified content you provided in your modified_files table for web_server_page.dart

import 'package:flutter/material.dart';
import 'package:your_project/services/log_service.dart';
import 'package:your_project/pages/log_page.dart';

class WebServerPage extends StatefulWidget {
  @override
  _WebServerPageState createState() => _WebServerPageState();
}

class _WebServerPageState extends State<WebServerPage> {
  StreamSubscription<String> _logSubscription;
  StreamSubscription<String> _uploadSubscription;

  @override
  void initState() {
    super.initState();
    _logSubscription = someLogStream.listen((log) {
      LogService.instance.addLog(log);
    });
    _uploadSubscription = someUploadStream.listen((upload) {
      LogService.instance.addLog(upload);
    });
  }

  @override
  void dispose() {
    _logSubscription?.cancel();
    _uploadSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Server'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Web Server Content'),
      ),
    );
  }

  void _copyToClipboard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
    } catch (e) {
      LogService.instance.addLog('Error copying to clipboard: $e');
    }
  }
}
