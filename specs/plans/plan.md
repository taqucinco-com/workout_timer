# 実装順

## Priority

- 音声入出力は最後に実装する
- 先にワイヤーフレームとなるUIで各画面が機能することを確認する
- タイマーも後で良いので、まずは状態遷移とその画面を作り上げる
- 設定は最後

1. まずdomainを定義する

- 状態やコマンドを定義する
- lib/feature/以下のディレクトリに作成する

2. 必要なパッケージを導入する

- hook_riverpod
- flutter_svg

3. HomePageとその下に状態分のScreenを用意する

- HomeはScaffoldの構築と他のページの遷移、ScreenなどからのLiftUpに専念する
- Screenは状態の数だけ存在する

4. 共通部品は lib/component/以下のディレクトリに作成する

- 7seg LEDの数字表示は共通部品にできる/Svgで数字を表示する

5. カウントダウンで行われる状態遷移はDebug専用のボタンで行い、先にホームの全体像を作り上げる

6. 次にタイマーを実装する

7. TTS/STTの実装をiOSのネイティブコードで行い、MethodChannel/EventChannelでFlutterから行う

    - Query/Command
    - lib/repository/以下に通信部分を作成する
    - コマンドへの変換や読み上げはlib/feature/以下に作成する

8. 音声入出力を既存の機能に統合する

9. 設定画面を作る