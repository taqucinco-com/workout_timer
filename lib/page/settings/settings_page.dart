import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final privacyPolicyUrl = Uri.parse('https://taqucinco-com.github.io/workout_timer/privacy-policy/');

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final opened = await launchUrl(privacyPolicyUrl, mode: .externalApplication);
    if (!opened) {
      messenger.showSnackBar(const SnackBar(content: Text('プライバシーポリシーを開けませんでした')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.orange.shade700,
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('プライバシーポリシー', style: TextStyle(color: Colors.orange.shade700)),
            trailing: Icon(Icons.open_in_new, color: Colors.orange.shade700),
            onTap: () => _openPrivacyPolicy(context),
          ),
        ],
      ),
    );
  }
}
