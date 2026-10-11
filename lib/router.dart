import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_timer/page/home/home_page.dart';
import 'package:workout_timer/page/settings/settings_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: HomePage(),
      ),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => const MaterialPage(
        child: SettingsPage(),
      ),
    ),
  ],
);
