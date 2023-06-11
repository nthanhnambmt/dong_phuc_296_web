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

class LoginFarmScreen extends StatefulWidget {
  const LoginFarmScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginFarmScreenState();
}

class LoginFarmScreenState extends State<LoginFarmScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

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
                            web296Login,
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ),
                          SizedBox(height: 40),
                          // _UsernameTextField(),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: web296LoginUsernameLabel,
                            myController: userNameController,
                          ),
                          SizedBox(height: 16),
                          // _PasswordTextField(),
                          PasswordInputWidget(
                            isReadOnly: false,
                            hintText: web296LoginPasswordLabel,
                            myController: passwordController,
                            isObscure: true,
                          ),
                          SizedBox(height: 24),
                          _RegisterAndNextButtons(
                              userNameController: userNameController,
                              passwordController: passwordController),
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
                    _RegisterAndNextButtons(
                        userNameController: userNameController,
                        passwordController: passwordController),
                  ],
                ),
              ),
            ),
    );
  }

// ProductModel createProductModel() {
//   return ProductModel(
//     productId: productIdController.text.toInt,
//     productName: productNameController.text,
//     productPrice: productPriceController.text.toInt,
//     assetAspectRatio: double.tryParse(productAspectRatioController.text),
//     catId: productCatIdController.text.toInt,
//     catName: productCatController.text,
//     dateCreated: DateTime.now(),
//     isShow: true,
//   );
// }
}

class _RegisterAndNextButtons extends StatelessWidget {
  const _RegisterAndNextButtons({
    required this.userNameController,
    required this.passwordController,
  });

  final TextEditingController userNameController;
  final TextEditingController passwordController;

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
                  .restorablePushNamed(Web296App.registerFarmRoute);
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                web296RegisterButtonCaption,
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
              appStateModel.logIn(
                  AccountModel(
                      userName: userNameController.text,
                      password: passwordController.text),
                  context);
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                web296Login,
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
