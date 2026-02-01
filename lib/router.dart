import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_timer/feature/page/home/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: HomePage(),
      ),
    ),
  ],
);
