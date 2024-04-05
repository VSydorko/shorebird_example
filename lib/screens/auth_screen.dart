import 'package:flutter/material.dart';

import 'package:restart_app/restart_app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:provider/provider.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import 'package:shorebird_example/blocs/index.dart';
import 'package:shorebird_example/router/index.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final AppLifecycleListener _listener;
  final shorebirdCodePush = ShorebirdCodePush();

  void _removeSplashScreen() {
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onStateChange: _checkForUpdates,
    );

    _checkForUpdates(AppLifecycleState.resumed);
  }

  Future<void> _checkForUpdates(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // Check whether a patch is available to install.
      final isUpdateAvailable =
          await shorebirdCodePush.isNewPatchAvailableForDownload();

      if (isUpdateAvailable) {
        // Download the new patch if it's available.
        await shorebirdCodePush.downloadUpdateIfAvailable();
        _showRestartBanner();
      }
    }
  }

  void _showRestartBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      const MaterialBanner(
        content: Text('A new patch is ready!'),
        actions: [
          TextButton(
            // Restart the app for the new patch to take effect.
            onPressed: Restart.restartApp,
            child: Text('Restart app'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthBloc>().state.status;

    return AutoRouter.declarative(
      routes: (_) {
        switch (authStatus) {
          case AuthenticationStatus.initial:
            return [];
          case AuthenticationStatus.unauthenticated:
            _removeSplashScreen();
            return [const LoginRoute()];
          case AuthenticationStatus.authenticated:
            _removeSplashScreen();
            return [const HomeRouter()];
        }
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    return super.dispose();
  }
}
