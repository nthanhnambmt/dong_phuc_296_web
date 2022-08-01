import 'package:dong_phuc_296_web/src/widgets/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../layout/letter_spacing.dart';
import '../screen/intro_screen.dart';
import '../util/colors.dart';
import '../util/strings.dart';

class EditTextWidget extends StatelessWidget {
  const EditTextWidget(this.hintText, this.myController);

  final String hintText;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PrimaryColorOverride(
      color: web296Brown900,
      child: TextField(
        controller: myController,
        textInputAction: TextInputAction.next,
        restorationId: 'username_text_field',
        cursorColor: colorScheme.onSurface,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing)),
        ),
      ),
    );
  }
}