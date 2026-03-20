import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/presentation/pages/login_page.dart';
import '../../features/auth/login/presentation/viewmodels/auth_viewmodel.dart';
import '../../features/auth/login/presentation/viewmodels/login_viewmodel.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/viewmodels/home_viewmodel.dart';
import '../../features/score/presentation/pages/score_page.dart';
import '../../features/score/presentation/viewmodels/score_viewmodel.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../di/injector.dart';
import '../logger/app_logger.dart';
import '../services/navigation_service.dart';
import 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    redirect: (context, state) => _redirect(
      context,
      state,
      injector(),
    ),
    refreshListenable: injector<AuthViewModel>(),
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: LoginPage(
            viewModel: injector<LoginViewModel>(),
          ),
          transitionsBuilder:
              (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(0.0, 0.3),
                        end: Offset.zero,
                      ).chain(
                        CurveTween(curve: Curves.easeOutCubic),
                      ),
                    ),
                    child: ScaleTransition(
                      scale: animation.drive(
                        Tween(
                          begin: 0.8,
                          end: 1.0,
                        ).chain(
                          CurveTween(curve: Curves.easeOutCubic),
                        ),
                      ),
                      child: child,
                    ),
                  ),
                );
              },
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => HomePage(
          viewModel: injector<HomeViewModel>(),
        ),
      ),
      GoRoute(
        path: AppRoutes.score,
        builder: (context, state) => ScorePage(
          viewModel: injector<ScoreViewModel>(),
        ),
      ),
    ],
  );

  static Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
    AppLogger logger,
  ) async {
    final authStore = injector<AuthViewModel>();
    final loggedIn = authStore.userLogged != null;
    final loggingIn = state.matchedLocation == AppRoutes.login;
    final registering = state.matchedLocation == AppRoutes.register;
    final isSplash = state.matchedLocation == AppRoutes.splash;

    if (isSplash) {
      final redirect = loggedIn ? AppRoutes.home : AppRoutes.login;
      return redirect;
    }

    // If not logged in and not on auth pages, redirect to login
    if (!loggedIn && !loggingIn && !registering) {
      return AppRoutes.login;
    }

    // If logged in and on auth pages, redirect to home
    if (loggedIn && (loggingIn || registering)) {
      return AppRoutes.home;
    }
    return null;
  }
}
