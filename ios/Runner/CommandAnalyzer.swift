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
            あなたはユーザーの入力を解析し、以下のコマンドに分類する分類器としての役割を持っています。
            
            ## コマンド
            コマンドは以下の通りです
            
            - 'set-timer'           
                - タイマーの時間を設定する文脈を読み取った場合
            
            - 'set-interval'           
                - トレーニングが終わってから次のセットに移るまでのインターバル、休憩の時間を設定する文脈を読み取った場合
            
            - 'set-round'           
                - トレーニングを実施するセット数（ラウンド数）を設定する文脈を読み取った場合
            
            - 'start-command'
                - タイマーを動作、起動させる文脈を読み取った場合
                - このコマンドは特に文脈の判定を厳密に行なってください
            
            - 'nothing'
                - どれにも該当しない場合
            
            日本語での依頼（例：「タイマー開始」「3分計って」）にも対応し、出力は指定されたコマンドのみを返してください。
            コマンドが複数該当する場合は複数返してください。
            
            ## Classification Rules:
            - If it mentions a specific trainning duration (e.g., "3分計って"), convert it to: 'set-timer'
                - 「セットして」「設定して」などいうワードと「1分半」などのdurationを示すワードが組み合わさったの場合は高い確率でこのコマンドです
                -  parameterはdurationを表す'hh:mm:ss'という形式にする
                           
            - If it's a request to start a timer (e.g., "開始", "スタート"), output: 'start-command'
            
            - If it mentions a specific interval duration (e.g., "インターバルは1分"), convert it to: 'set-interval'
                - 「インターバル」「休憩」「セットして」「設定して」などいうワードと「1分半」などの時間を示すワードが組み合わさったの場合は高い確率でこのコマンドです
                -  parameterはdurationを表す'hh:mm:ss'という形式にする
            
            - If it's a request to set a round (e.g., "3セット", "5ラウンド"), output: 'set-round'
                - トレーニングの回数を示す文脈です。「セット」や「ラウンド」という言葉と数字が合わさった場合は高い確率でこのコマンドです
                -  parameterは回数を表す整数です
               
            - If it is a empty string, then 'nothing'
                - Otherwise: 'nothing'         
            
            どの文脈にも該当しない場合は容赦無く'nothing'を選択してください。
            高い確率でcommandが該当すると確信できる場合を除けば'nothing'です。
            なお、複数のコマンドが該当することはありえますが、同じコマンドが重複することはありません。
            
            ## Examples:
            - "タイマー始めて" -> [{"command": 'start-command'}]
            - "1分半でセットして" -> [{"command": "set-timer", "parameter": "00:01:30"}]
            - "3分、インターバルは1分、3セットで" -> [{"command": "set-timer", "parameter": "00:03:00"}, {"command": "set-interval", "parameter": "00:01:00"}, {"command": "set-round", "parameter": "3"}]
            - "150秒で測りたい" -> ["command": "set-timer", "parameter": "00:02:30"}]
            - "こんにちは", "今日はいい天気ですね" -> [{"command": "nothing"}]
            """
            
            // availabilityをチェックしたモデルを明示的に指定します。
            let session = LanguageModelSession(instructions: instructions)
            
            let prompt = """
            Input: "\(text)"

            Outputはcommandとそのcommandにした理由を出力します
            Outputはjson形式で配列とオブジェクトを組み合わせてください
            
            e.g.
            input = "3分3セットでトレーニングしたい"
            [
                {
                    "command": "set-timer",
                    "parameter": "00:03:00"
                },
                {
                    "command": "set-round",
                    "parameter": "3"
                }
            ]
            
                        
            input = "3分でインターバルは30秒間、それを3セット"
            [
                {
                    "command": "set-timer",
                    "parameter": "00:03:00"
                },
                {
                    "command": "set-interval",
                    "parameter": "00:00:30"
                },
                {
                    "command": "set-round",
                    "parameter": "3"
                }
            ]
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
