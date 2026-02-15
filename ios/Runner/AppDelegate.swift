import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    let analyzer = CommandAnalyzer()
    let speechRecognizer = SpeechRecognizer()
    
    private var eventSink: FlutterEventSink?
    
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let commandChannel = FlutterMethodChannel(
            name: "workout-timer.taqucinco.com/command",
            binaryMessenger: controller.binaryMessenger
        )
        commandChannel.setMethodCallHandler({[weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            guard let self = self else { return }
            
            switch call.method {
            case "analyzeCommand":
                guard let text = call.arguments as? String else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Argument must be a String.", details: nil))
                    return
                }
                Task {
                    let analysisResult = await self.analyzer.analyzeCommand(text: text)
                    result(analysisResult)
                }
                
            case "idle":
                Task { @MainActor in
                    await self.speechRecognizer.idle()
                    result(0)
                }
            case "startRecognizer":
                speechRecognizer.resetTranscript()
                speechRecognizer.startTranscribing()
                result(0)
            case "stopRecognizer":
                speechRecognizer.stopTranscribing()
                result(0)
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        let eventChannel = FlutterEventChannel(name: "workout-timer.taqucinco.com/recognizer", binaryMessenger: controller.binaryMessenger)
        eventChannel.setStreamHandler(self)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        
        speechRecognizer.onTranscriptToken = { token in
            guard let sink = self.eventSink else {
                return
            }
            sink(token)
        }
        
//        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
//            guard let sink = self.eventSink else {
//                timer.invalidate()
//                return
//            }
//            sink("iOSからの定期通知: \(Date().description)")
//            
//            // エラーを送る場合はこう書きます
//            // sink(FlutterError(code: "UNAVAILABLE", message: "Error message", details: nil))
//            
//            // ストリームを終了させる場合はこう書きます
//            // sink(FlutterEndOfEventStream)
//        }
        
        return nil
    }

    // Flutter側で cancel() が呼ばれた時（またはDispose時）に実行される
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}

