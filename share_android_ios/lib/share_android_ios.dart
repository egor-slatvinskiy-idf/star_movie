import 'package:flutter/services.dart';

class ShareAndroidIos {
  static const MethodChannel _channel =
      const MethodChannel('share_android_ios');

  static Future<void> share(String message) async {
    await _channel.invokeMethod('share', {'message': message});
  }
}
