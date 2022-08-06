// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dongphuc296web/src/widgets/cut_corners_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../layout/letter_spacing.dart';
import '../util/colors.dart';

const defaultLetterSpacing = 0.03;
const mediumLetterSpacing = 0.04;
const largeLetterSpacing = 1.0;

final ThemeData web296Theme = _buildShrineTheme();

//TODO: Màu của icon trong web
IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: web296Brown900);
}

ThemeData _buildShrineTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
    ),
    colorScheme: _web296ColorScheme,
    primaryColor: web296Pink100,
    scaffoldBackgroundColor: web296BackgroundWhite,
    cardColor: web296BackgroundWhite,
    errorColor: web296ErrorRed,
    primaryIconTheme: _customIconTheme(base.iconTheme),
    inputDecorationTheme: const InputDecorationTheme(
      border: CutCornersBorder(
        borderSide: BorderSide(color: web296Brown900, width: 0.5),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    ),
    textTheme: _buildWeb296TextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: web296Pink100,
    ),
    primaryTextTheme: _buildWeb296TextTheme(base.primaryTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildWeb296TextTheme(TextTheme base) {
  //TODO: chỉnh font chữ cho web https://www.vietrick.com/font-chu-tieng-viet-dep-tren-google-fonts/

  return GoogleFonts.robotoTextTheme(base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        bodyText2: base.bodyText2!.copyWith(
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        subtitle1: base.subtitle1!.copyWith(
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        headline4: base.headline4!.copyWith(
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        button: base.button!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
      )
      .apply(
        displayColor: web296Brown900,
        bodyColor: web296Brown900,
      ));
}

const ColorScheme _web296ColorScheme = ColorScheme(
  primary: web296Pink100,
  primaryContainer: web296Brown900,
  secondary: web296Pink50,
  secondaryContainer: web296Brown900,
  surface: web296SurfaceWhite,
  background: web296BackgroundWhite,
  error: web296ErrorRed,
  onPrimary: web296Brown900,
  onSecondary: web296Brown900,
  onSurface: web296Brown900,
  onBackground: web296Brown900,
  onError: web296SurfaceWhite,
  brightness: Brightness.light,
);
