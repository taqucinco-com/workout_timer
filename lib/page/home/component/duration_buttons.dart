import 'package:flutter/material.dart';

class DurationButtons extends StatelessWidget {
  const DurationButtons({super.key, required this.onDurationChanged});

  final ValueChanged<Duration> onDurationChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            onDurationChanged(const Duration(minutes: 5));
          },
          child: Text('+5m', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            onDurationChanged(const Duration(minutes: 3));
          },
          child: Text('+3m', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            onDurationChanged(const Duration(minutes: 1));
          },
          child: Text('+1m', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            onDurationChanged(const Duration(seconds: 30));
          },
          child: Text('+30s', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            onDurationChanged(const Duration(seconds: 10));
          },
          child: Text('+10s', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            onDurationChanged(const Duration(seconds: 1));
          },
          child: Text('+1s', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
