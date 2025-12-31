import 'package:flutter/material.dart';
import '../services/log_service.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  void initState() {
    super.initState();
    LogService.instance.addListener(_onLogsChanged);
  }

  @override
  void dispose() {
    LogService.instance.removeListener(_onLogsChanged);
    super.dispose();
  }

  void _onLogsChanged() {
    setState(() {});
  }

  void _clearLogs() {
    LogService.instance.clearLogs();
  }

  @override
  Widget build(BuildContext context) {
    final logs = LogService.instance.logs;

    return Scaffold(
      appBar: AppBar(
        title: Text('Log Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Clear Logs',
            onPressed: _clearLogs,
          ),
          // Placeholder for copy logs button if needed
          // IconButton(
          //   icon: Icon(Icons.copy),
          //   tooltip: 'Copy Logs',
          //   onPressed: () {},
          // ),
        ],
      ),
      body: logs.isEmpty
          ? Center(child: Text('No logs available'))
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                final time = DateTime.fromMillisecondsSinceEpoch(log.timestamp);
                final formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
                return ListTile(
                  title: Text(log.message),
                  subtitle: Text(formattedTime),
                );
              },
            ),
    );
  }
}
