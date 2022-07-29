import 'package:flutter/material.dart';

import '../util/colors.dart';

class DialogButtonWidget extends StatelessWidget {
  const DialogButtonWidget({required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (onTap != null) {
          onTap!();
        }
        Navigator.of(context).pop(text);
      },
      child: Text(text, style: TextStyle(color: web296Pink400)),
    );
  }
}
