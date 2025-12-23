import 'package:flutter/material.dart';
import '../services/settings_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsService _settings = SettingsService();
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _portController;
  late TextEditingController _sharedDirController;
  
  bool _isLoading = true;
  bool _isSaving = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);
    try {
      await _settings.loadSettings();
      _portController = TextEditingController(text: _settings.port.toString());
      _sharedDirController = TextEditingController(text: _settings.sharedDir);
    } catch (e) {
      setState(() => _errorMessage = 'Failed to load settings: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isSaving = true;
      _errorMessage = null;
      _successMessage = null;
    });
    
    try {
      final port = int.tryParse(_portController.text);
      if (port == null) throw ArgumentError('Port must be a number');
      await _settings.savePort(port);
      await _settings.saveSharedDir(_sharedDirController.text);
      
      setState(() => _successMessage = 'Settings saved successfully!');
    } catch (e) {
      setState(() => _errorMessage = 'Failed to save settings: $e');
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _resetToDefaults() async {
    setState(() {
      _isSaving = true;
      _errorMessage = null;
      _successMessage = null;
    });
    
    try {
      await _settings.resetToDefaults();
      await _loadSettings(); // Reload controllers with defaults
      setState(() => _successMessage = 'Settings reset to defaults.');
    } catch (e) {
      setState(() => _errorMessage = 'Failed to reset settings: $e');
    } finally {
      setState(() => _isSaving = false);
    }
  }

  String? _validatePort(String? value) {
    if (value == null || value.isEmpty) return 'Port is required';
    final port = int.tryParse(value);
    if (port == null) return 'Port must be a number';
    if (port < 1 || port > 65535) return 'Port must be between 1 and 65535';
    return null;
  }

  String? _validateSharedDir(String? value) {
    if (value == null || value.isEmpty) return 'Shared directory path is required';
    // Additional validation could check if path exists, but we'll keep simple
    return null;
  }

  @override
  void dispose() {
    _portController.dispose();
    _sharedDirController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSettings,
            tooltip: 'Reload settings',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Port setting
                    Text('Server Port', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _portController,
                      decoration: const InputDecoration(
                        hintText: 'e.g., 8080',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.settings_ethernet),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validatePort,
                    ),
                    const SizedBox(height: 24),

                    // Shared directory setting
                    Text('Shared Directory Path', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sharedDirController,
                      decoration: const InputDecoration(
                        hintText: 'Path to shared folder',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.folder),
                      ),
                      validator: _validateSharedDir,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Note: Leave empty to use default directory (Documents/LANFileTransfer/shared)',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 32),

                    // Messages
                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 8),
                            Expanded(child: Text(_errorMessage!)),
                          ],
                        ),
                      ),
                    if (_successMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Expanded(child: Text(_successMessage!)),
                          ],
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isSaving ? null : _saveSettings,
                            icon: const Icon(Icons.save),
                            label: const Text('Save Settings'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _isSaving ? null : _resetToDefaults,
                            icon: const Icon(Icons.restore),
                            label: const Text('Reset to Defaults'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Changes will take effect after restarting the web server.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
