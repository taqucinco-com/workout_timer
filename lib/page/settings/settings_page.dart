import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final privacyPolicyUrl = Uri.parse('https://taqucinco-com.github.io/workout_timer/privacy-policy/');
final termOfUseUrl = Uri.parse('https://taqucinco-com.github.io/workout_timer/term-of-use');

final packageInfoProvider = FutureProvider<PackageInfo>((ref) => PackageInfo.fromPlatform());

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  Future<void> _openExternalUrl(BuildContext context, Uri url, String errorMessage) async {
    final messenger = ScaffoldMessenger.of(context);
    final opened = await launchUrl(url, mode: .externalApplication);
    if (!opened && context.mounted) {
      messenger.showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final version = packageInfo.when(
      data: (info) => '${info.version} (${info.buildNumber})',
      loading: () => '-',
      error: (_, _) => '-',
    );

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
            onTap: () => _openExternalUrl(context, privacyPolicyUrl, 'プライバシーポリシーを開けませんでした'),
          ),
          ListTile(
            title: Text('利用規約', style: TextStyle(color: Colors.orange.shade700)),
            trailing: Icon(Icons.open_in_new, color: Colors.orange.shade700),
            onTap: () => _openExternalUrl(context, termOfUseUrl, '利用規約を開けませんでした'),
          ),
          ListTile(
            title: Text('バージョン', style: TextStyle(color: Colors.orange.shade700)),
            trailing: Text(version, style: TextStyle(color: Colors.orange.shade700)),
          ),
        ],
      ),
    );
  }
}
