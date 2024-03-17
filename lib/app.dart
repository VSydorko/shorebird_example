import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:shorebird_example/app_state_wrapper.dart';
import 'package:shorebird_example/router/index.dart';
import 'package:shorebird_example/services/index.dart';
import 'package:shorebird_example/styles/index.dart';

class ShorebirdExample extends StatelessWidget {
  ShorebirdExample({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getAppTheme(context),
        routerConfig: _appRouter.config(
          navigatorObservers: () => [RouterObserver(LoggerService.instance)],
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
