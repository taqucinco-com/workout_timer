# プライバシーポリシー 設計

- `lib/page/settings/settings_page.dart`: 設定画面。`ListView`に`プライバシーポリシー`の`ListTile`を置く。
- `lib/router.dart`: `/settings`ルートを追加し、`HomeSideMenu`の`Settings`ボタンから`context.push`で遷移する。
- 外部URLは`url_launcher`の`LaunchMode.externalApplication`で開く。Androidでは`AndroidManifest.xml`の`<queries>`に`https`のVIEWインテントを宣言する（パッケージ可視性のため）。
- ポリシーのURL: `https://taqucinco-com.github.io/workout_timer/privacy-policy/`
- データモデルの変更は無い。
