//
//  CommandAnalyzer.swift
//  Runner
//
//  Created by takuya.sudo on 2026/02/11.
//

import Foundation
import FoundationModels

@Generable
struct CommandOutput: Codable {
    let command: String
    let parameter: String?
}

class CommandAnalyzer {
    private var model = SystemLanguageModel.default
    
    // Apple Intelligenceのオンデバイスモデルを使用してテキストを解析
    func analyzeCommand(text: String) async -> String {
        guard model.availability == .available else {
            print("Default model is not available.")
            // ここで適切なフォールバック処理を実装できます
            return "not available"
        }

        do {
            let instructions = """
            あなたはユーザーの入力を解析し、定義されたコマンドに分類する分類器です。
            出力は必ずJSON形式の `[CommandOutput]` 配列としてください。

            ## コマンドの定義
            
            - `set-timer`: トレーニング時間を設定する。
              - **必須条件:** "分", "秒", "時間"などの時間単位、または数値を必ず含む。
              - **パラメータ:** "hh:mm:ss"形式の時間文字列。
            
            - `set-interval`: インターバル（休憩時間）を設定する。
              - **必須条件:** "インターバル", "休憩"などのキーワードと、時間単位または数値を必ず含む。
              - **パラメータ:** "hh:mm:ss"形式の時間文字列。
            
            - `set-round`: セット数（ラウンド数）を設定する。
              - **必須条件:** "セット", "ラウンド"などのキーワードと、数値を必ず含む。
              - **パラメータ:** 回数を表す整数文字列。
            
            - `start-command`: タイマーを開始する。
              - **条件:** 「スタート」「開始」のような、時間や回数の設定を含まない純粋な開始命令。
            
            - `stop-command`: タイマーを停止する。
              - **条件:** 「ストップ」「止めて」のような、純粋な停止命令。
            
            - `nothing`: 上記のいずれにも該当しない。
              - **条件:** 挨拶、無関係な発言など。

            ## 解析ルール
            1.  **厳密な条件適用:** `set-timer`, `set-interval`, `set-round` は、それぞれの**必須条件**（キーワードと言語・数値）が満たされない限り、**絶対に使用しないでください**。
            2.  **単純命令の優先:** 「スタート」のような単一の単語の場合、他のコマンド（特に `set-timer` や `set-interval`）を含めず、`start-command` のみを出力してください。
            3.  **確信が持てない場合:** 少しでもコマンドの定義から外れる、または曖昧な場合は、`nothing` を返すか、該当するコマンドを含めないでください。
            4.  **複数コマンド:** 複数の明確な指示がある場合のみ、複数のコマンドを配列に含めてください。
            """
            
            // availabilityをチェックしたモデルを明示的に指定します。
            let session = LanguageModelSession(instructions: instructions)
            
            let prompt = """
            ユーザーからの入力を解析し、定義されたコマンド形式のJSONとして出力する例を以下に示します。

            入力: "1分半セットして"
            出力:
            [
                {
                    "command": "set-timer",
                    "parameter": "00:01:30"
                }
            ]
            ---
            入力: "3分、インターバルは1分、3セットで"
            出力:
            [
                {
                    "command": "set-timer",
                    "parameter": "00:03:00"
                },
                {
                    "command": "set-interval",
                    "parameter": "00:01:00"
                },
                {
                    "command": "set-round",
                    "parameter": "3"
                }
            ]
            ---
            入力: "スタート"
            出力:
            [
                {
                    "command": "start-command"
                }
            ]
            ---
            入力: "こんにちは"
            出力:
            [
                {
                    "command": "nothing"
                }
            ]
            ---

            それでは、以下のユーザー入力を解析してください。

            入力: "\(text)"
            出力:
            """
            
            let response = try await session.respond(to: prompt, generating: [CommandOutput].self)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(response.content)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Successfully received response: \(response)")
                return String(describing: jsonString)
            } else {
                print("Fialed received response: \(response)")
                return ""
            }
        } catch {
            print("An error occurred: \(error)")
            return ""
        }
    }
}
