// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:dong_phuc_296_web/src/widgets/theme.dart';
import 'package:flutter/material.dart';

import '../data/gallery_options.dart';
import '../layout/adaptive.dart';
import '../layout/image_placeholder.dart';
import '../layout/letter_spacing.dart';
import '../layout/text_scale.dart';
import '../util/constants.dart';
import '../util/strings.dart';
import '../app.dart';
import '../util/colors.dart';
import '../util/utils.dart';
import '../widgets/web_296_logo_widget.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return ApplyTextOptions(
      child: isDesktop
          ? LayoutBuilder(
              builder: (context, constraints) => Scaffold(
                body: SafeArea(
                  child: Center(
                    child: SizedBox(
                      width: Utils.desktopLoginScreenMainAreaWidth(context: context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Web296LogoWidget(),
                          SizedBox(height: 40),
                          _UsernameTextField(),
                          SizedBox(height: 16),
                          _PasswordTextField(),
                          SizedBox(height: 24),
                          _CancelAndNextButtons(),
                          SizedBox(height: 62),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              body: SafeArea(
                child: ListView(
                  restorationId: 'login_list_view',
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  children: const [
                    SizedBox(height: 80),
                    Web296LogoWidget(),
                    SizedBox(height: 120),
                    _UsernameTextField(),
                    SizedBox(height: 12),
                    _PasswordTextField(),
                    _CancelAndNextButtons(),
                  ],
                ),
              ),
            ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PrimaryColorOverride(
      color: web296Brown900,
      child: TextField(
        textInputAction: TextInputAction.next,
        restorationId: 'username_text_field',
        cursorColor: colorScheme.onSurface,
        decoration: InputDecoration(
          labelText: web296LoginUsernameLabel,
          labelStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing)),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PrimaryColorOverride(
      color: web296Brown900,
      child: TextField(
        restorationId: 'password_text_field',
        cursorColor: colorScheme.onSurface,
        obscureText: true,
        decoration: InputDecoration(
          labelText: web296LoginPasswordLabel,
          labelStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing)),
        ),
      ),
    );
  }
}

class _CancelAndNextButtons extends StatelessWidget {
  const _CancelAndNextButtons();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isDesktop = isDisplayDesktop(context);

    final buttonTextPadding = isDesktop
        ? const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
        : EdgeInsets.zero;

    return Padding(
      padding: isDesktop ? EdgeInsets.zero : const EdgeInsets.all(8),
      child: OverflowBar(
        spacing: isDesktop ? 0 : 8,
        alignment: MainAxisAlignment.end,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            onPressed: () {
              // The login screen is immediately displayed on top of
              // the Shrine home screen using onGenerateRoute and so
              // rootNavigator must be set to true in order to get out
              // of Shrine completely.
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                web296CancelButtonCaption,
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            onPressed: () {
              Navigator.of(context).restorablePushNamed(ShrineApp.homeRoute);
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                web296NextButtonCaption,
                style: TextStyle(
                    letterSpacing: letterSpacingOrNone(largeLetterSpacing)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({
    super.key,
    this.color,
    required this.child,
  });

  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: color),
      child: child,
    );
  }
}
