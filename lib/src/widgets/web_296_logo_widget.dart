import 'package:flutter/material.dart';

import '../layout/image_placeholder.dart';
import '../util/strings.dart';

class Web296LogoWidget extends StatelessWidget {
  const Web296LogoWidget();

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Column(
        children: [
          const FadeInImagePlaceholder(
            image: AssetImage(logoPath),
            placeholder: SizedBox(
              width: 34,
              height: 34,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            textDongPhuc296,
            style: Theme.of(context).primaryTextTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}