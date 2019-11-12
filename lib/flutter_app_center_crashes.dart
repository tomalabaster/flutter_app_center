import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_center/src/crashes/flutter_app_center_crash_report.dart';

class FlutterAppCenterCrashes {
  static const MethodChannel _channel =
      const MethodChannel('flutter_app_center/crashes');

  static String get id => (defaultTargetPlatform == TargetPlatform.iOS)
      ? "MSCrashes"
      : "com.microsoft.appcenter.crashes.Crashes";

  static Future<void> generateTestCrash() =>
      _channel.invokeMethod('generateTestCrash');

  static Future<bool> get hasReceivedMemoryWarningInLastSession =>
      _channel.invokeMethod('hasReceivedMemoryWarningInLastSession');

  static Future<bool> get hasCrashedInLastSession =>
      _channel.invokeMethod('hasCrashedInLastSession');

  static Future<FlutterAppCenterCrashReport> get lastSessionCrashReport async {
    var report = await _channel
        .invokeMapMethod<String, dynamic>('lastSessionCrashReport');

    return FlutterAppCenterCrashReport.fromMap(report);
  }

  static Future<void> setEnabled(bool enabled) =>
      _channel.invokeMethod('setEnabled', {'enabled': enabled});

  static Future<bool> get isEnabled => _channel.invokeMethod('isEnabled');

  static Future<void> disableMachExceptionHandler() async {
    if (Platform.isIOS) {
      await _channel.invokeMethod('disableMachExceptionHandler');
    }

    return;
  }
}
