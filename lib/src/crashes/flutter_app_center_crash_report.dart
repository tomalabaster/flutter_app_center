import 'package:flutter_app_center/src/crashes/flutter_app_center_device.dart';

class FlutterAppCenterCrashReport {
  final DateTime appErrorTime;
  final int appProcessIdentifier;
  final DateTime appStartTime;
  final String exceptionName;
  final String exceptionReason;
  final String incidentIdentifier;
  final String reporterKey;
  final FlutterAppCenterDevice device;

  FlutterAppCenterCrashReport(
      this.appErrorTime,
      this.appProcessIdentifier,
      this.appStartTime,
      this.exceptionName,
      this.exceptionReason,
      this.incidentIdentifier,
      this.reporterKey,
      this.device);

  factory FlutterAppCenterCrashReport.fromMap(Map<String, dynamic> map) {
    if (map == null || map.isEmpty) {
      return null;
    }

    return FlutterAppCenterCrashReport(
        DateTime.fromMillisecondsSinceEpoch(map['appErrorTime'] as int),
        map['appProcessIdentifier'] as int,
        DateTime.fromMillisecondsSinceEpoch(map['appStartTime'] as int),
        map['exceptionName'] as String,
        map['exceptionReason'] as String,
        map['incidentIdentifier'] as String,
        map['reporterKey'] as String,
        FlutterAppCenterDevice.fromMap(
            Map.castFrom<dynamic, dynamic, String, dynamic>(map['device'])));
  }

  Map<String, dynamic> toMap() {
    return {
      'appErrorTime': this.appErrorTime,
      'appProcessIdentifier': this.appProcessIdentifier,
      'appStartTime': this.appStartTime,
      'exceptionName': this.exceptionName,
      'exceptionReason': this.exceptionReason,
      'incidentIdentifier': this.incidentIdentifier,
      'reporterKey': this.reporterKey,
      'device': this.device
    };
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
