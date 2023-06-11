// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const Color bgCategory = web296Pink50;
const Color web296Pink50 = Color(0xFFDAF5E8);
const Color web296Pink75 = Color(0xFFCEF1E2);
const Color web296Pink100 = Color(0xFFA4E0C9);
const Color web296Pink300 = Color(0xFF51A182);
const Color web296Pink400 = Color(0xFF286955);

const Color web296Brown900 = Color(0xFF442B2D);
const Color web296Brown600 = Color(0xFF7D4F52);

const Color web296ErrorRed = Color(0xFFC5032B);
const Color web296Blue = Color(0xFF0340C5);

const Color web296SurfaceWhite = Color(0xFFFFFBFA);
const Color web296BackgroundWhite = Colors.white;

// const Color bgCategory = web296Pink50;
// const Color web296Pink50 = Color(0xFFFEEAE6);
// const Color web296Pink100 = Color(0xFFFEDBD0);
// const Color web296Pink300 = Color(0xFFFBB8AC);
// const Color web296Pink400 = Color(0xFFEAA4A4);
//
// const Color web296Brown900 = Color(0xFF442B2D);
// const Color web296Brown600 = Color(0xFF7D4F52);
//
// const Color web296ErrorRed = Color(0xFFC5032B);
//
// const Color web296SurfaceWhite = Color(0xFFFFFBFA);
// const Color web296BackgroundWhite = Colors.white;

class FarmColors {
  static const List<Color> accountColors = <Color>[
    Color(0xFF005D57),
    Color(0xFF04B97F),
    Color(0xFF37EFBA),
    Color(0xFF007D51),
  ];

  static const List<Color> billColors = <Color>[
    Color(0xFFFFDC78),
    Color(0xFFFF6951),
    Color(0xFFFFD7D0),
    Color(0xFFFFAC12),
  ];

  static const List<Color> budgetColors = <Color>[
    Color(0xFFB2F2FF),
    Color(0xFFB15DFF),
    Color(0xFF72DEFF),
    Color(0xFF0082FB),
  ];

  static const Color gray = Color(0xFFD8D8D8);
  static const Color gray60 = Color(0x99D8D8D8);
  static const Color gray25 = Color(0x40D8D8D8);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color primaryBackground = Color(0xFF33333D);
  static const Color inputBackground = Color(0xFF26282F);
  static const Color cardBackground = Color(0x03FEFEFE);
  static const Color buttonColor = Color(0xFF09AF79);
  static const Color focusColor = Color(0xCCFFFFFF);
  static const Color dividerColor = Color(0xAA282828);

  /// Convenience method to get a single account color with position i.
  static Color accountColor(int i) {
    return cycledColor(accountColors, i);
  }

  /// Convenience method to get a single bill color with position i.
  static Color billColor(int i) {
    return cycledColor(billColors, i);
  }

  /// Convenience method to get a single budget color with position i.
  static Color budgetColor(int i) {
    return cycledColor(budgetColors, i);
  }

  /// Gets a color from a list that is considered to be infinitely repeating.
  static Color cycledColor(List<Color> colors, int i) {
    return colors[i % colors.length];
  }
}