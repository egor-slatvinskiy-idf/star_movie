import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'share_android_ios_platform_interface.dart';

class MethodChannelShareAndroidIos extends ShareAndroidIosPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('share_android_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
