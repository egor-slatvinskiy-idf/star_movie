import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'share_android_ios_method_channel.dart';

abstract class ShareAndroidIosPlatform extends PlatformInterface {
  ShareAndroidIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static ShareAndroidIosPlatform _instance = MethodChannelShareAndroidIos();

  static ShareAndroidIosPlatform get instance => _instance;
  
  static set instance(ShareAndroidIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
