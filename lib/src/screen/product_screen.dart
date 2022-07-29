import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/model/app_state_model.dart';
import '../layout/adaptive.dart';
import '../widgets/asymmetric_view.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
      return isDesktop
          ? DesktopAsymmetricView(products: model.getProducts())
          : MobileAsymmetricView(products: model.getProducts());
    });
  }
}
