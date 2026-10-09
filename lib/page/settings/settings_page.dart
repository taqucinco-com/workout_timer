import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final termOfUseUrl = Uri.parse('https://taqucinco-com.github.io/workout_timer/term-of-use');

final packageInfoProvider = FutureProvider<PackageInfo>((ref) => PackageInfo.fromPlatform());

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final version = packageInfo.when(
      data: (info) => '${info.version} (${info.buildNumber})',
      loading: () => '-',
      error: (_, _) => '-',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('利用規約'),
            trailing: const Icon(Icons.open_in_new),
            // アプリ内WebViewではなく外部ブラウザで開く
            onTap: () => launchUrl(termOfUseUrl, mode: .externalApplication),
          ),
          ListTile(title: const Text('バージョン'), trailing: Text(version)),
        ],
      ),
    );
  }
}
