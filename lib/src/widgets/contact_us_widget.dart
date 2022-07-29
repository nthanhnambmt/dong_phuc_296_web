import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../util/colors.dart';
import '../util/strings.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({
    Key? key,
    this.icon,
    required this.iconSize,
    required this.title,
    required this.content,
    required this.isClickable,
  }) : super(key: key);

  final IconData? icon;
  final double? iconSize;
  final String title;
  final String content;
  final bool isClickable;

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
            isClickable
                ? InkWell(
                    child: Text(content,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: web296Brown600,
                            ),
                        maxLines: 2,
                        softWrap: true),
                    onTap: () => launchUrlString(callPhoneButton))
                : Text(
                    content,
                    style: Theme.of(context).textTheme.subtitle2,
                  )
          ],
        )
      ],
    );
  }
}
