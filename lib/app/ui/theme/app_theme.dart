import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: colorBlue,
  splashColor: colorBlue,
  highlightColor: colorBlue,
);

SystemUiOverlayStyle get styleWithSimpleNavigationBar {
  return const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  );
}