
import 'flutter_biometric_platform_interface.dart';

class FlutterBiometric {
  Future<String?> getPlatformVersion() {
    return FlutterBiometricPlatform.instance.getPlatformVersion();
  }
}
