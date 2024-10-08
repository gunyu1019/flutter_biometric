import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_biometric_method_channel.dart';

abstract class FlutterBiometricPlatform extends PlatformInterface {
  /// Constructs a FlutterBiometricPlatform.
  FlutterBiometricPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterBiometricPlatform _instance = MethodChannelFlutterBiometric();

  /// The default instance of [FlutterBiometricPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterBiometric].
  static FlutterBiometricPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterBiometricPlatform] when
  /// they register themselves.
  static set instance(FlutterBiometricPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion();

  Future<BiometricStatus> canAuthorization();

  Future<bool> authorize();
}
