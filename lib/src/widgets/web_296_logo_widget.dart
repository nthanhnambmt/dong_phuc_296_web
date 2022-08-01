import 'package:flutter/material.dart';

import '../layout/image_placeholder.dart';
import '../util/strings.dart';

class Web296LogoWidget extends StatelessWidget {
  // const DeferredLoadingPlaceholder({
  //   super.key,
  //   this.name = 'This widget',
  // });
  const Web296LogoWidget({this.isSmallText = false});

  final bool isSmallText;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Column(
        children: [
          FadeInImagePlaceholder(
            height: isSmallText ? 50 : 100,
            image: AssetImage(logoPath),
            placeholder: SizedBox(
              width: 34,
              height: 34,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            textDongPhuc296,
            style: isSmallText
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context).primaryTextTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
