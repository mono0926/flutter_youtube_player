import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_kit/mono_kit.dart';

const _primaryColor = Color(0xFFFC091C);

ThemeData buildLightTheme() {
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
    ),
  ).followLatestSpec().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          textTheme: appBartTextTheme,
          iconTheme: const IconThemeData(
            color: Color(0xFF666666),
          ),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F3F3),
      );
}

ThemeData buildDarkTheme() {
  return ThemeData.from(
    colorScheme: const ColorScheme.dark(
      secondary: _primaryColor,
    ),
  ).followLatestSpec();
}
