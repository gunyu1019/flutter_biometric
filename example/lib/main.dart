import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_biometric/flutter_biometric.dart';
import 'package:flutter_biometric/options/android_option.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatefulWidget {
    const MyApp({super.key});

    @override
    State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    String _platformVersion = 'Unknown';
    final _flutterBiometricPlugin = FlutterBiometric();

    @override
    void initState() {
        super.initState();
        initPlatformState();
    }

    // Platform messages are asynchronous, so we initialize in an async method.
    Future<void> initPlatformState() async {
        String platformVersion;
        // Platform messages may fail, so we use a try/catch PlatformException.
        // We also handle the message potentially returning null.
        try {
            var l = await _flutterBiometricPlugin.canAuthorization();
            if (l == null) {
                platformVersion = "Unknown platform version";
            } else {
                platformVersion = l.name;
            }
        } on PlatformException {
            platformVersion = 'Failed to get platform version.';
        }

        // If the widget was removed from the tree while the asynchronous platform
        // message was in flight, we want to discard the reply rather than calling
        // setState to update our non-existent appearance.
        if (!mounted) return;

        setState(() {
            _platformVersion = platformVersion;
        });
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: const Text('Plugin example app'),
                ),
                body: Center(
                    child: Text('Running on: $_platformVersion\n'),
                ),
                floatingActionButton: FloatingActionButton(
                    onPressed: () {
                        _flutterBiometricPlugin.authenticate(
                            'Biometric Authenticate',
                            AndroidOption(
                                negativeButtonText: "취소"
                            )
                        );
                    },
                    tooltip: 'Authenticate',
                    child: const Icon(Icons.fingerprint),
                ),
            ),
        );
    }
}
