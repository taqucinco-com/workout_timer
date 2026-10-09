import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/onboarding/mic_guide_store.dart';
import 'package:workout_timer/feature/onboarding/mic_guide_store.impl.dart';

final micGuideStoreProvider = Provider<MicGuideStore>((_) => MicGuideStoreImpl());
