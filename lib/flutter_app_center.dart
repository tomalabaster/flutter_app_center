import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAppCenter {
  static const MethodChannel _channel =
      const MethodChannel('flutter_app_center');

  static Future<void> start(String secret, List<String> services) async =>
      await _channel
          .invokeMethod('start', {'secret': secret, 'services': services});

  static Future<void> setLogLevel([int logLevel = 99]) async =>
      await _channel.invokeMethod('setLogLevel', {'logLevel': logLevel});

  static Future<String> get installId async =>
      _channel.invokeMethod('installId');

  static Future<void> setUserId(String userId) async =>
      await _channel.invokeMethod('setUserId', {'userId': userId});

  static Future<void> setEnabled(bool enabled) async =>
      await _channel.invokeMethod('setEnabled', {'enabled': enabled});

  static Future<bool> get isEnabled async => _channel.invokeMethod('isEnabled');

  static Future<String> get sdkVersion async =>
      _channel.invokeMethod('sdkVersion');
}
