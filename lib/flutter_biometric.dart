
import 'flutter_biometric_platform_interface.dart';
import 'biometric_status.dart';
import 'options/base_option.dart';

class FlutterBiometric {
    Future<String?> getPlatformVersion() {
        return FlutterBiometricPlatform.instance.getPlatformVersion();
    }
    
    Future<BiometricStatus> canAuthorization() {
        return FlutterBiometricPlatform.instance.canAuthorization();
    }

    Future<bool> authenticate(
        String title,
        BaseOption option
    ) {
        return FlutterBiometricPlatform.instance.authenticate();
    }
}