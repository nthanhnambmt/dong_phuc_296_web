import 'package:dongphuc296web/src/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/model/product_model.dart';
import '../util/colors.dart';
import '../util/constants.dart';
import '../util/strings.dart';

class CartRowWidget extends StatelessWidget {
  const CartRowWidget({
    super.key,
    required this.product,
    required this.quantity,
    this.onRemoveCartItemPressed,
    this.onAddCartItemPressed,
    required this.startColumnWidth,
  });

  final double startColumnWidth;
  final ProductModel product;
  final int? quantity;
  final VoidCallback? onRemoveCartItemPressed;
  final VoidCallback? onAddCartItemPressed;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: vnLocales.toString(),
    );
    final localTheme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        key: ValueKey<int>(product.productId.valueOrZeroInt),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildButtonAddCartItem(context),
          buildCartItemContent(formatter, context, localTheme),
          buildButtonRemoveCartItem(context),
        ],
      ),
    );
  }

  Expanded buildCartItemContent(
      NumberFormat formatter, BuildContext context, ThemeData localTheme) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  product.getImageName,
                  package: product.getThumbNail,
                  fit: BoxFit.cover,
                  width: 75,
                  height: 75,
                  excludeFromSemantics: true,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MergeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MergeSemantics(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                '$web296ProductQuantity:  $quantity',
                              ),
                              SelectableText(
                                // '$web296ProductPrice:    ${formatter.format(product.price)}',
                                '${formatter.format((product.getProductSubTotal(quantity)))}',
                              ),
                            ],
                          ),
                        ),
                        SelectableText(
                          product.productName.valueOrEmptyString(),
                          style: localTheme.textTheme.subtitle1!
                              .copyWith(fontWeight: FontWeight.w600),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              color: web296Brown900,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Semantics buildButtonAddCartItem(BuildContext context) {
    return Semantics(
      container: true,
      label: '$web296ScreenReaderAddProductButton ${product.productName}',
      button: true,
      enabled: true,
      child: ExcludeSemantics(
        child: SizedBox(
          width: startColumnWidth,
          child: IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: onAddCartItemPressed,
            tooltip: web296TooltipAddItem,
          ),
        ),
      ),
    );
  }

  Semantics buildButtonRemoveCartItem(BuildContext context) {
    return Semantics(
      container: true,
      label: '$web296ScreenReaderRemoveProductButton ${product.productName}',
      button: true,
      enabled: true,
      child: ExcludeSemantics(
        child: SizedBox(
          width: startColumnWidth,
          child: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: onRemoveCartItemPressed,
            tooltip: web296TooltipRemoveItem,
          ),
        ),
      ),
    );
  }
}
