import Cocoa
import FlutterMacOS

public class ShareAndroidIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "share_android_ios", binaryMessenger: registrar.messenger)
    let instance = ShareAndroidIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     if call.method == "share" {
           let arguments = call.arguments as! [String: Any]
           let message = arguments["message"] as! String
           share(message)
           result(nil)
         } else {
           result(FlutterMethodNotImplemented)
         }
  }

    private func share(_ message: String) {
        let sharingPicker = NSSharingServicePicker(items: [message])
        if let contentView = NSApplication.shared.keyWindow?.contentViewController?.view {
            let nsRect = NSRect(x: contentView.bounds.maxX - 130, y:
              contentView.bounds.maxY, width: 1, height: 1)
            sharingPicker.show(relativeTo: nsRect, of:
              contentView, preferredEdge: .maxX)
        }
    }
}
