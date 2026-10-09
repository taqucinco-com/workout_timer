import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_timer/feature/onboarding/mic_guide_store.dart';

class MicGuideStoreImpl implements MicGuideStore {
  static const _key = 'mic_guide_shown';

  @override
  Future<bool> hasShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  @override
  Future<void> markShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }

  @override
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
