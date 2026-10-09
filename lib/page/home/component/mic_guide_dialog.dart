import 'package:flutter/material.dart';

/// マイクボタンを初めて使うときに、音声で設定できる内容を例つきで説明する。
Future<void> showMicGuideDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(Icons.mic, color: Colors.orange.shade700, size: 40),
      title: const Text('声でタイマーを設定できます'),
      content: const Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text('マイクをタップして話しかけてください。'),
          SizedBox(height: 12),
          Text('例:'),
          Text('「3分3セット、30秒インターバルで設定して」'),
        ],
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
    ),
  );
}
