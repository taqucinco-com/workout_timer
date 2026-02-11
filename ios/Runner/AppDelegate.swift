import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    let analyzer = CommandAnalyzer()
    
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
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}


