/// マイクボタンの初回説明を表示済みかどうかを保持する。
abstract interface class MicGuideStore {
  Future<bool> hasShown();

  Future<void> markShown();

  /// 開発者用。表示済みフラグを消して、次回のマイクボタンタップで再び説明を表示させる。
  Future<void> reset();
}
