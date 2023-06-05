import 'package:dongphuc296web/src/widgets/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../layout/letter_spacing.dart';
import '../screen/intro_screen.dart';
import '../util/colors.dart';

class EditTextWidget extends StatelessWidget {
  const EditTextWidget({
    required this.hintText,
    required this.myController,
    this.inputFormatters,
    this.validator,
    this.onTextChange,
    required this.isReadOnly,
  });

  final String hintText;
  final bool isReadOnly;
  final TextEditingController myController;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onTextChange;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PrimaryColorOverride(
      color: web296Brown900,
      child: TextFormField(
        readOnly: isReadOnly,
        controller: myController,
        onChanged: (value) {
          debugPrint('-------------EditTextWidget onChanged: ${value}');

          // if (onTextChange != null)
          onTextChange!(value);
        },
        textInputAction: TextInputAction.next,
        cursorColor: colorScheme.onSurface,
        validator: validator,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing)),
        ),
      ),
    );
  }
}
