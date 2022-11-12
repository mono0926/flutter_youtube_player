import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

const _primaryColor = Color(0xFFFC091C);

ThemeData buildLightTheme(BuildContext context) {
  final typography = Typography.material2018();
  var appBartTextTheme = typography.englishLike
      .merge(typography.black)
      .apply(fontFamily: GoogleFonts.teko().fontFamily);
  appBartTextTheme = appBartTextTheme.copyWith(
    headline6: appBartTextTheme.headline6.copyWith(
      fontSize: 28,
    ),
  );

  return ThemeData.from(
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      secondary: Colors.blueAccent,
    ),
  ).followLatestSpec().copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xFF666666),
        ),
        brightness: context.select(
          (ThemeNotifier theme) => theme.appBarBrightness,
        ), toolbarTextStyle: appBartTextTheme.bodyText2, titleTextStyle: appBartTextTheme.headline6,
      ),
      scaffoldBackgroundColor: const Color(0xFFF3F3F3),
      dividerColor: Colors.black38);
}

// TODO(mono): 対応
ThemeData buildDarkTheme() {
  return ThemeData.from(
    colorScheme: const ColorScheme.dark(
      secondary: _primaryColor,
    ),
  ).followLatestSpec();
}

class ThemeNotifier with ChangeNotifier {
  var _appBarBrightness = Brightness.light;
  Brightness get appBarBrightness => _appBarBrightness;
  set appBarBrightness(Brightness brightness) {
    if (_appBarBrightness == brightness) {
      return;
    }
    _appBarBrightness = brightness;
    notifyListeners();
  }
}
