import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_timer/feature/onboarding/mic_guide_store.impl.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('初期状態は未表示で、markShown後は表示済み、reset後は未表示に戻る', () async {
    final store = MicGuideStoreImpl();
    expect(await store.hasShown(), isFalse);

    await store.markShown();
    expect(await store.hasShown(), isTrue);

    await store.reset();
    expect(await store.hasShown(), isFalse);
  });
}
