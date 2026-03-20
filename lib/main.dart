import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';

import 'core/application_config.dart';
import 'core/controllers/update_controller.dart';
import 'core/di/injector.dart';
import 'core/helpers/error_handler.dart';
import 'core/routes/router_config.dart';
import 'core/services/sentry_service.dart';
import 'core/services/shorebird_update_service.dart';
import 'core/ui/ui_config.dart';
import 'core/ui/widgets/android_back_button_handler.dart';

Future<void> main() async {
  // Wrapper para inicialização do app
  Future<void> appRunner() async {
    // Lock orientation to landscape for Android
    if (Platform.isAndroid) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    await ApplicationConfig().consfigureApp();

    // Initialize window manager only for Windows and MacOS
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

  // Sentry desabilitado no Linux devido a incompatibilidade com GLX
  // Causa: BadAccess error ao tentar acessar recursos gráficos do X Window System
  if (Platform.isLinux) {
    await appRunner();
  } else {
    await SentryService.init(appRunner: appRunner);
  }
}

class Weblurk extends StatefulWidget {
  const Weblurk({super.key});

  @override
  State<Weblurk> createState() => _WeblurklState();
}

class _WeblurklState extends State<Weblurk> {
  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    // Aguarda um pequeno delay para garantir que a UI esteja pronta
    await Future.delayed(const Duration(seconds: 2));

    // Use the new MVVM structure through UpdateController
    final updateService = ShorebirdUpdateService();

    // Executar diagnóstico primeiro
    await updateService.debugShorebird();

    final hasUpdate = await updateService.checkForUpdates();
    if (hasUpdate && mounted) {
      // Use the new MVVM UpdateController
      final updateController = UpdateController();
      await updateController.checkAndShowUpdateDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1366, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AndroidBackButtonHandler(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            title: UiConfig.title,
            theme: UiConfig.theme,
          ),
        );
      },
    );
  }
}
