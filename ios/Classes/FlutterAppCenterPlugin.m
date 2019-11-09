#import "FlutterAppCenterPlugin.h"
#import <flutter_app_center/flutter_app_center-Swift.h>

@implementation FlutterAppCenterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAppCenterPlugin registerWithRegistrar:registrar];
}
@end
