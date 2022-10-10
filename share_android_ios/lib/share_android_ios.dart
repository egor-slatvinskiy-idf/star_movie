import 'package:flutter/services.dart';

class ShareAndroidIos {
  static const MethodChannel _channel = MethodChannel('share_android_ios');

  static Future<void> share(String message) async {
    try {
      await _channel.invokeMethod('share', {'message': message});
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }
}
