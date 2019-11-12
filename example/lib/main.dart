import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_app_center/flutter_app_center.dart';
import 'package:flutter_app_center/flutter_app_center_analytics.dart';
import 'package:flutter_app_center/flutter_app_center_crashes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    await FlutterAppCenter.start(
        Platform.isIOS
            ? '72945258-6a1c-42a0-ae71-cefd0cfb985d'
            : '34cd3d3d-9d80-4998-85d7-3f02738902d6',
        [FlutterAppCenterAnalytics.id, FlutterAppCenterCrashes.id]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App Center'),
        ),
        body: Center(
            child: Column(children: [
          Text('Flutter App Center'),
          RaisedButton(
            child: Text('Track event'),
            onPressed: () async {
              await FlutterAppCenterAnalytics.trackEvent(
                  'test', {'testProp': 'testVal', 'testProp2': 2});
            },
          ),
          RaisedButton(
            child: Text('Pause Analytics'),
            onPressed: () async {
              await FlutterAppCenterAnalytics.pause();
            },
          ),
          RaisedButton(
            child: Text('Resume Analytics'),
            onPressed: () async {
              await FlutterAppCenterAnalytics.resume();
            },
          ),
          RaisedButton(
            child: Text('Toggle Analytics'),
            onPressed: () async {
              var enabled = await FlutterAppCenterAnalytics.isEnabled;
              await FlutterAppCenterAnalytics.setEnabled(!enabled);
            },
          ),
          RaisedButton(
            child: Text('Generate test crash'),
            onPressed: () async {
              await FlutterAppCenterCrashes.generateTestCrash();
            },
          ),
          RaisedButton(
            child: Text('Has received memory warning in last session'),
            onPressed: () async {
              print(await FlutterAppCenterCrashes
                  .hasReceivedMemoryWarningInLastSession);
            },
          ),
          RaisedButton(
            child: Text('Has crashed in last session'),
            onPressed: () async {
              print(await FlutterAppCenterCrashes.hasCrashedInLastSession);
            },
          ),
          RaisedButton(
            child: Text('Last session crash report'),
            onPressed: () async {
              var crashReport =
                  await FlutterAppCenterCrashes.lastSessionCrashReport;
              print(crashReport);
            },
          ),
          RaisedButton(
            child: Text('Toggle Crashes'),
            onPressed: () async {
              var enabled = await FlutterAppCenterCrashes.isEnabled;
              await FlutterAppCenterCrashes.setEnabled(!enabled);
            },
          ),
          RaisedButton(
            child: Text('Disable Mach exception handler'),
            onPressed: () async {
              await FlutterAppCenterCrashes.disableMachExceptionHandler();
            },
          )
        ])),
      ),
    );
  }
}
