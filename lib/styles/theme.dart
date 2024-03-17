import 'package:flutter/material.dart';

import 'package:shorebird_example/styles/index.dart';

class AppTheme {
  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
      fontFamily: FontFamily.poppins,
    );
  }
}
