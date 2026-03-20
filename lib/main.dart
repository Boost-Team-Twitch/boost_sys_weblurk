import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

import 'core/app/weblurk_app.dart';
import 'core/application_config.dart';
import 'core/di/injector.dart';
import 'core/helpers/error_handler.dart';
import 'core/services/sentry_service.dart';

Future<void> main() async {
  Future<void> appRunner() async {
    if (Platform.isAndroid) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    await ApplicationConfig().consfigureApp();

    if (Platform.isWindows || Platform.isMacOS) {
      await windowManager.ensureInitialized();
      final WindowOptions windowOptions = const WindowOptions(
        size: Size(1366, 768),
        minimumSize: Size(1366, 768),
        center: true,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }

    await Injector.setup();
    ErrorHandler.setupErrorHandling();
    runApp(const Weblurk());
  }

  if (Platform.isLinux) {
    await appRunner();
  } else {
    await SentryService.init(appRunner: appRunner);
  }
}
