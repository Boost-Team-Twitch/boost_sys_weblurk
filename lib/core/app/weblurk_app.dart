import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/update_controller.dart';
import '../routes/router_config.dart';
import '../services/shorebird_update_service.dart';
import '../ui/ui_config.dart';
import '../ui/widgets/android_back_button_handler.dart';

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
    await Future.delayed(const Duration(seconds: 2));

    final updateService = ShorebirdUpdateService();
    await updateService.debugShorebird();

    final hasUpdate = await updateService.checkForUpdates();
    if (hasUpdate && mounted) {
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
