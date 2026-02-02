// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/legacy.dart';
import 'package:workout_timer/feature/training/training_menu.dart';
import 'package:workout_timer/feature/training/training_menu_progress.dart';

final pendingTrainingMenuProvider = StateProvider<TrainingMenu>((_) => TrainingMenu.zero());
final trainingMenuProvider = StateProvider<TrainingMenu>((_) => TrainingMenu.zero());
final trainingProgressProvider = StateProvider<TrainingMenuProgress?>((_) => null);
