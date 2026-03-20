import 'package:flutter/material.dart';

enum ScreenType { tablet, desktop, desktopLarge }

class ResponsiveBreakpoints {
  ResponsiveBreakpoints._();

  static const double tabletMinWidth = 720;
  static const double desktopMinWidth = 1366;
  static const double desktopLargeMinWidth = 1920;

  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= desktopLargeMinWidth) return ScreenType.desktopLarge;
    if (width >= desktopMinWidth) return ScreenType.desktop;
    return ScreenType.tablet;
  }

  static bool isTablet(BuildContext context) =>
      getScreenType(context) == ScreenType.tablet;

  static bool isDesktop(BuildContext context) =>
      getScreenType(context) == ScreenType.desktop ||
      getScreenType(context) == ScreenType.desktopLarge;

  static bool isDesktopLarge(BuildContext context) =>
      getScreenType(context) == ScreenType.desktopLarge;

  static T responsiveValue<T>(
    BuildContext context, {
    required T tablet,
    required T desktop,
    T? desktopLarge,
  }) {
    final type = getScreenType(context);
    return switch (type) {
      ScreenType.desktopLarge => desktopLarge ?? desktop,
      ScreenType.desktop => desktop,
      ScreenType.tablet => tablet,
    };
  }
}
