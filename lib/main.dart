import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/framework/life_cycle/life_cycle_listener.provider.dart';
import 'package:workout_timer/router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _EagerInitialization(
      child: MaterialApp.router(
        title: 'Workout Timer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom().copyWith(
              textStyle: WidgetStateProperty.resolveWith(
                (states) => switch (states) {
                  _ when states.contains(WidgetState.disabled) => TextStyle(color: Colors.grey),
                  _ => TextStyle(color: Colors.orange.shade700),
                },
              ),
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => switch (states) {
                  _ => Colors.transparent,
                },
              ),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              side: WidgetStateProperty.resolveWith((states) => BorderSide(color: Colors.orange.shade700)),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
            ),
          ),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(lifeCycleListenerProvider.select((s) => null));
    return child;
  }
}
