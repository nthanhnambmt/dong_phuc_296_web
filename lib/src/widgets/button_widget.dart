import 'package:dongphuc296web/src/widgets/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../layout/letter_spacing.dart';
import '../util/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return
      // PositionedDirectional(
      // bottom: 16,
      // start: 16,
      // end: 16,
      // child:
      Semantics(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            primary: web296Pink100,
          ),
          onPressed: () {
            if (onTap != null) {
              onTap!();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              buttonText,
              style: TextStyle(
                  letterSpacing: letterSpacingOrNone(largeLetterSpacing)),
            ),
          ),
        ),
      // ),
    );
  }
}
