# Style Guide

このスタイルガイドは、Gemini Code AssistによるPRレビュー時に参照されるプロジェクトのコーディング規約です。

## 言語

日本語で返答してください

## 開発環境・ツール設定

### Flutter/Dartコマンド

flutter, dartのバージョンはfvmで管理しています。flutter, dartコマンドはfvmコマンド経由で使用してください。

- `fvm flutter pub get`
- `fvm flutter run`
- `fvm flutter pub run build_runner watch --delete-conflicting-outputs`

### コード生成

ソースコードを変更する前に予め`fvm flutter pub run build_runner watch --delete-conflicting-outputs`を実行して裏で走らせておいてください。変更を監視して自動生成します。

## ライブラリ・フレームワーク

### 状態管理 (hooks_riverpod)

- 状態管理に使用
- StateNotifier を適切に活用
- Widget は `HookWidget` または `ConsumerWidget` を使用
- Provider は可能な限りスコープを絞り、粒度の細かいリビルドを避ける

### ルーティング (go_router)

- 画面遷移管理
- ShellRoute, Nested Routes なども必要に応じて利用
- **型安全なGoRouteDataクラスを使用**（例: `SignInOtpRoute`）
- **ハードコードされたルートパスは避ける**（例: `'/signin/otp'`はNG）

ルート定義は `lib/ui/route/app_router.dart` に記載されています。

**推奨される画面遷移方法**:
```dart
// ✅ 正しい
SignInOtpRoute(email).go(context)

// ❌ 避けるべき
GoRouter.of(context).go('/signin/otp')
```

### HTTPクライアント (dio)

- HTTP クライアント
- Interceptor を使った共通処理を設計

### コード生成

- **freezed**: 不変データクラス、Union を生成。JsonSerializable を組み合わせてモデルを自動生成
- **freezed で生成したモデルクラスを経由してデータを扱う**

### テスト (mockito)

- テスト用のモックオブジェクト生成
- Repository や外部依存のテストダブルを作成
- build_runner と組み合わせてモックを自動生成
- `test/mock/generate.dart` にMockすべきclassを追記

## コーディング規約

### Widget定義

基本的にWidgetを返すビルダー関数を作成するよりも、StatelessWidget等新たなWidgetを定義してください。
理由: 再利用性と保守性の向上

### パターンマッチ

riverpodのwhenの機能よりも、switch文を優先してつかってください。
より強力なパターンマッチが使えるためです。

### import

基本的に相対pathでimportするのではなく、絶対pathでimportしてください。

```dart
// ✅ 正しい
import 'package:magma_app/framework/log/app_log.dart';

// ❌ 避けるべき
import '../../framework/log/app_log.dart';
```

### ネーミング

英語で一貫性を持たせてください。

### コードの簡潔性

できる限りシンプルに書いてください。複雑な実装を避け、シンプルなコードを優先します。

### double.infinityの使用

double.infinityの使用を可能な限り避けてください。レイアウト設計ではdouble.infinityの使用を最小限にしてください。

### 個人情報の扱い

個人情報は可能な限り`$extra`を使用して渡してください。パラメータとして直接渡すのではなく、`$extra`を活用します。

### コレクションリテラル（null-aware-element）

リストやマップのリテラルでは、null-aware-elementを使用してください。

参考: https://dart.dev/language/collections#null-aware-element

```dart
// ✅ 正しい（リスト）
[
  item1,
  ?item2,
  item3,
]

// ❌ 避けるべき（リスト）
[
  item1,
  if (item2 != null) item2!,
  item3,
]

// ✅ 正しい（マップ）
{
  'key1': value1,
  'key2': ?item2,
  'key3': value3,
}

// ❌ 避けるべき（マップ）
{
  'key1': value1,
  if (item2 != null) 'key2': item2!,
  'key3': value3,
}
```

null-aware-elementは条件がfalseの場合、要素が含まれない（nullではなく要素が存在しない）ことを意味します。

配列操作に関しては参照透過性の高いコードを推奨します。リテラルやメソッドチェーンで表現できるならばそのようなシンタックスを優先してください。
関数型プログラミングの流儀に従い、高階関数を積極的に利用しましょう。

```dart
final numbers = [2, 3, 4, 5, 6, 7, 8];
final knownNumbers = [1, 81];

// ✅ 推奨（リテラルとメソッドチェーンで表現され、finalで変数が定義されてから変更されない）
final expLessThan10GeneratedByEven = [
  ...numbers
    .where((e) => e % 2 == 0)
    .where(exp),
  ...knownNumbers,
]
  .where((e) < 10.0)
  .sorted((a, b) => a < b)

// ❌ 避けるべき（不要な変数が作れる、しかもその変数が定義後の操作により状態が目まぐるしく変わる）
final evenNumbers = <int>[];
for (final number in numbers) {
  if (number % 0) {
    evenNumbers.add(number);
  }
}
final expLessThan10 = <double>[];
for (final number in evenNumbers) {
  final e = exp(number);
  if (e < 10.0) {
    expLessThan10.add(e);
  }
}
for (final number in knownNumbers) {
  if (number < 10.0) {
    expLessThan10.add(number);
  }
}
expLessThan10.sort((a, b) => a < b)

```

## Git操作

コミットの処理は明確な指示が無い限り行わないで下さい

## Pull request

プルリクエストのテンプレートは `.github/PULL_REQUEST_TEMPLATE.md` にあるので参照してください。
基本的にdevelopブランチと現在のブランチとの差分を見て生成してください。

## GitHub連携

GitHubのリンクを指定した場合、基本的にMCPを使って接続してください。

## MCP

github, notion, figmaのページはprivate設定です。アクセスする場合はMCPを経由してください。

## 実装時の推奨事項

### 推奨される実装

- レイヤーを意識したクリーンな構造
- Riverpod Provider の定義例
- go_router を使ったルート設定
- dio のインターセプタ設計例
- freezed を使ったモデルクラス
- 型安全なGoRouteDataクラスを使用
- Widget抽出時は適切な粒度を考慮（Molecule/Organism）

### 避けるべき実装

- setState による状態管理
- 無計画なグローバル変数の利用
- ハードコードされたルートパス
- double.infinityの過度な使用
- 相対pathでのimport
- Colors.* や Color(0xFF...) の直接使用

## シークレット管理

シークレットはGoogle Secret Managerで管理しています。

アクセス方法:
- `gcloud auth login`
- `gcloud config set project`
- `gcloud secrets list`
- `gcloud secrets versions access`

設定ファイル: `dart-define-from-file`
