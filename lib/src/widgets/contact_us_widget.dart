import 'package:flutter/material.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({
    Key? key,
    this.icon,
    required this.iconSize,
    required this.title,
    required this.content,
  }) : super(key: key);

  final IconData? icon;
  final double? iconSize;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconSize != null
            ? Icon(
                icon,
                size: iconSize,
              )
            : Icon(icon),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              content,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ],
    );
  }
}
