import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_biometric_platform_interface.dart';
import 'biometric_status.dart';
import 'options/base_option.dart';

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

    @override
    Future<BiometricStatus> canAuthorization() async {
        final result = await methodChannel.invokeMethod<int>('canAuthorization');
        return BiometricStatus.fromId(result!!)
    }

    @override
    Future<bool> authenticate(
        String title,
        BaseOption option
    ) async {
        var argument = option.toArgument();
        argument['title'] = title;
        final result = await methodChannel.invokeMethod<bool>('authenticate', argument);
        return result ?? false;
    }
}
