// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:dongphuc296web/src/data/model/account_model.dart';
import 'package:dongphuc296web/src/widgets/theme.dart';
import 'package:dongphuc296web/src/widgets/web_296_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../app.dart';
import '../../data/gallery_options.dart';
import '../../data/model/app_state_model.dart';
import '../../layout/adaptive.dart';
import '../../layout/letter_spacing.dart';
import '../../util/colors.dart';
import '../../util/constants.dart';
import '../../util/strings.dart';
import '../../util/utils.dart';
import '../../widgets/edit_text_widget.dart';
import '../../widgets/password_input_widget.dart';

class RegisterFarmScreen extends StatefulWidget {
  const RegisterFarmScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterFarmScreenState();
}

class RegisterFarmScreenState extends State<RegisterFarmScreen> {
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final registerCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return ApplyTextOptions(
      child: isDesktop
          ? LayoutBuilder(
              builder: (context, constraints) => Scaffold(
                body: SafeArea(
                  child: Center(
                      child: Column(children: [
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        textWebMo,
                        style: Theme.of(context).primaryTextTheme.displayMedium,
                      ),
                    ),
                    SizedBox(
                      width: Utils.desktopLoginScreenMainAreaWidth(
                          context: context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            web296Register,
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ),
                          SizedBox(height: 40),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: web296RegisterFullNameLabel,
                            myController: fullNameController,
                          ),
                          SizedBox(height: 16),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: web296LoginUsernameLabel,
                            myController: userNameController,
                          ),
                          SizedBox(height: 16),
                          PasswordInputWidget(
                            isReadOnly: false,
                            hintText: web296LoginPasswordLabel,
                            myController: passwordController,
                            isObscure: false,
                          ),
                          SizedBox(height: 16),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: web296RegisterCodeLabel,
                            myController: registerCodeController,
                          ),
                          SizedBox(height: 24),
                          _CancelAndNextButtons(
                            userNameController: userNameController,
                            fullNameController: fullNameController,
                            passwordController: passwordController,
                            registerCodeController: registerCodeController,
                          ),
                          SizedBox(height: 62),
                        ],
                      ),
                    ),
                  ])),
                ),
              ),
            )
          : Scaffold(
              body: SafeArea(
                child: ListView(
                  restorationId: 'login_list_view',
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  children: [
                    SizedBox(height: 80),
                    Web296LogoWidget(),
                    SizedBox(height: 120),
                    EditTextWidget(
                      isReadOnly: false,
                      hintText: web296LoginUsernameLabel,
                      myController: userNameController,
                    ),
                    SizedBox(height: 12),
                    EditTextWidget(
                      isReadOnly: false,
                      hintText: web296LoginPasswordLabel,
                      myController: passwordController,
                    ),
                    // _CancelAndNextButtons(),
                  ],
                ),
              ),
            ),
    );
  }
}

class _CancelAndNextButtons extends StatelessWidget {
  const _CancelAndNextButtons({
    required this.fullNameController,
    required this.userNameController,
    required this.passwordController,
    required this.registerCodeController,
  });

  final TextEditingController fullNameController;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController registerCodeController;

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
              Navigator.of(context)
                  .restorablePushNamed(Web296App.loginFarmRoute);
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
              final appStateModel = ScopedModel.of<AppStateModel>(context);
              appStateModel.registerAccount(
                  AccountModel(
                    userName: userNameController.text,
                    fullName: fullNameController.text,
                    password: passwordController.text,
                    registerCode: registerCodeController.text,
                  ),
                  context);
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                web296Register,
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
