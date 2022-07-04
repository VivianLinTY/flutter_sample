import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var index : Int = 0
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let messagesChannel = FlutterMethodChannel(name: "com.wtfff.sample/messages", binaryMessenger: controller.binaryMessenger)
        messagesChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
            guard call.method == "getMessage" else {
            result(FlutterMethodNotImplemented)
            return
            }
            self?.receiveMessage(result: result)
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func receiveMessage(result: FlutterResult) {
        let returnVal = false
        if returnVal {
            result(FlutterError(code: "UNAVAILABLE",
                                message: "No message",
                                details: nil))
        } else {
            index += 1
            result("test \(index)")
        }
    }
}
