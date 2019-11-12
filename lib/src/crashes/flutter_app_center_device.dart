class FlutterAppCenterDevice {
  final String appBuild;
  final String appNamespace;
  final String appVersion;
  final String carrierCountry;
  final String carrierName;
  final String locale;
  final String model;
  final String oemName;
  final int osApiLevel;
  final String osBuild;
  final String osName;
  final String osVersion;
  final String screenSize;
  final String sdkName;
  final String sdkVersion;
  final String liveUpdateDeploymentKey;
  final String liveUpdatePackageHash;
  final String liveUpdateReleaseLabel;
  final String wrapperRuntimeVersion;
  final String wrapperSdkName;
  final String wrapperSdkVersion;

  FlutterAppCenterDevice(
      this.appBuild,
      this.appNamespace,
      this.appVersion,
      this.carrierCountry,
      this.carrierName,
      this.locale,
      this.model,
      this.oemName,
      this.osApiLevel,
      this.osBuild,
      this.osName,
      this.osVersion,
      this.screenSize,
      this.sdkName,
      this.sdkVersion,
      this.liveUpdateDeploymentKey,
      this.liveUpdatePackageHash,
      this.liveUpdateReleaseLabel,
      this.wrapperRuntimeVersion,
      this.wrapperSdkName,
      this.wrapperSdkVersion);

  factory FlutterAppCenterDevice.fromMap(Map<String, dynamic> map) {
    if (map == null || map.isEmpty) {
      return null;
    }

    return FlutterAppCenterDevice(
        map['appBuild'] as String,
        map['appNamespace'] as String,
        map['appVersion'] as String,
        map['carrierCountry'] as String,
        map['carrierName'] as String,
        map['locale'] as String,
        map['model'] as String,
        map['oemName'] as String,
        map['osApiLevel'] as int,
        map['osBuild'] as String,
        map['osName'] as String,
        map['osVersion'] as String,
        map['screenSize'] as String,
        map['sdkName'] as String,
        map['sdkVersion'] as String,
        map['liveUpdateDeploymentKey'] as String,
        map['liveUpdatePackageHash'] as String,
        map['liveUpdateReleaseLabel'] as String,
        map['wrapperRuntimeVersion'] as String,
        map['wrapperSdkName'] as String,
        map['wrapperSdkVersion'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'appBuild': this.appBuild,
      'appNamespace': this.appNamespace,
      'appVersion': this.appVersion,
      'carrierCountry': this.carrierCountry,
      'carrierName': this.carrierName,
      'locale': this.locale,
      'model': this.model,
      'oemName': this.oemName,
      'osApiLevel': this.osApiLevel,
      'osBuild': this.osBuild,
      'osName': this.osName,
      'osVersion': this.osVersion,
      'screenSize': this.screenSize,
      'sdkName': this.sdkName,
      'sdkVersion': this.sdkVersion,
      'liveUpdateDeploymentKey': this.liveUpdateDeploymentKey,
      'liveUpdatePackageHash': this.liveUpdatePackageHash,
      'liveUpdateReleaseLabel': this.liveUpdateReleaseLabel,
      'wrapperRuntimeVersion': this.wrapperRuntimeVersion,
      'wrapperSdkName': this.wrapperSdkName,
      'wrapperSdkVersion': this.wrapperSdkVersion
    };
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
