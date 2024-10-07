import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_biometric_platform_interface.dart';

/// An implementation of [FlutterBiometricPlatform] that uses method channels.
class MethodChannelFlutterBiometric extends FlutterBiometricPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_biometric');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
