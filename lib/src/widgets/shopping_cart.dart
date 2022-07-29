// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dong_phuc_296_web/src/util/constants.dart';
import 'package:dong_phuc_296_web/src/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../layout/letter_spacing.dart';
import '../util/strings.dart';
import '../util/colors.dart';
import '../util/utils.dart';
import 'expanding_bottom_sheet.dart';
import '../data/model/app_state_model.dart';
import '../data/model/product.dart';

const _startColumnWidth = 60.0;
const _ordinalSortKeyName = 'shopping_cart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Widget> _createShoppingCartRows(AppStateModel model) {
    return model.productsInCart.keys
        .map(
          (id) => ShoppingCartRow(
            product: model.getProductById(id),
            quantity: model.productsInCart[id],
            onRemoveCartItemPressed: () {
              model.removeItemFromCart(id);
            },
            onAddCartItemPressed: () {
              model.addProductToCart(id);
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: web296Pink50,
      body: SafeArea(
        child: ScopedModelDescendant<AppStateModel>(
          builder: (context, child, model) {
            final expandingBottomSheet = ExpandingBottomSheet.of(context);
            return Stack(
              children: [
                ListView(
                  children: [
                    Semantics(
                      sortKey:
                          const OrdinalSortKey(0, name: _ordinalSortKeyName),
                      child: Row(
                        children: [
                          SizedBox(
                            width: _startColumnWidth,
                            child: IconButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onPressed: () => expandingBottomSheet!.close(),
                              tooltip: web296TooltipCloseCart,
                            ),
                          ),
                          Text(
                            web296CartPageCaption,
                            style: localTheme.textTheme.subtitle1!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${model.totalCartQuantity} $web296CartItemCount ',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Semantics(
                      sortKey:
                          const OrdinalSortKey(1, name: _ordinalSortKeyName),
                      child: Column(
                        children: _createShoppingCartRows(model),
                      ),
                    ),
                    Semantics(
                      sortKey:
                          const OrdinalSortKey(2, name: _ordinalSortKeyName),
                      child: ShoppingCartSummary(model: model),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
                PositionedDirectional(
                  bottom: 16,
                  start: 16,
                  end: 16,
                  child: Semantics(
                    sortKey: const OrdinalSortKey(3, name: _ordinalSortKeyName),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        primary: web296Pink100,
                      ),
                      onPressed: () {
                        Utils.showTwoButtonDialog(context, cartClearQuestion,
                            () {
                          setState(() {
                            model.clearCart();
                            expandingBottomSheet!.close();
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          web296CartClearButtonCaption,
                          style: TextStyle(
                              letterSpacing:
                                  letterSpacingOrNone(largeLetterSpacing)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ShoppingCartSummary extends StatelessWidget {
  const ShoppingCartSummary({
    super.key,
    required this.model,
  });

  final AppStateModel model;

  @override
  Widget build(BuildContext context) {
    final smallAmountStyle =
        Theme.of(context).textTheme.bodyText2!.copyWith(color: web296Brown600);
    final largeAmountStyle = Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(letterSpacing: letterSpacingOrNone(mediumLetterSpacing));
    final formatter = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: vnLocales.toString(),
    );

    return Row(
      children: [
        const SizedBox(width: _startColumnWidth),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: Column(
              children: [
                MergeSemantics(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SelectableText(
                        web296CartTotalCaption,
                      ),
                      Expanded(
                        child: SelectableText(
                          formatter.format(model.totalCost),
                          style: largeAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                MergeSemantics(
                  child: Row(
                    children: [
                      SelectableText(
                        web296CartSubtotalCaption,
                      ),
                      Expanded(
                        child: SelectableText(
                          formatter.format(model.subtotalCost),
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                MergeSemantics(
                  child: Row(
                    children: [
                      SelectableText(
                        web296CartShippingCaption,
                      ),
                      Expanded(
                        child: SelectableText(
                          formatter.format(model.shippingCost),
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                MergeSemantics(
                  child: Row(
                    children: [
                      SelectableText(
                        web296CartTaxCaption,
                      ),
                      Expanded(
                        child: SelectableText(
                          formatter.format(model.tax),
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShoppingCartRow extends StatelessWidget {
  const ShoppingCartRow({
    super.key,
    required this.product,
    required this.quantity,
    this.onRemoveCartItemPressed,
    this.onAddCartItemPressed,
  });

  final Product product;
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
        key: ValueKey<int>(product.id),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          Semantics(
            container: true,
            label:
                '$web296ScreenReaderAddProductButton ${product.name(context)}',
            button: true,
            enabled: true,
            child: ExcludeSemantics(
              child: SizedBox(
                width: _startColumnWidth,
                child: IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: onAddCartItemPressed,
                  tooltip: web296TooltipAddItem,
                ),
              ),
            ),
          ),
          //   ],
          // ),
          Expanded(
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
                                product.name(context),
                                style: localTheme.textTheme.subtitle1!
                                    .copyWith(fontWeight: FontWeight.w600),
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
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          Semantics(
            container: true,
            label:
                '$web296ScreenReaderRemoveProductButton ${product.name(context)}',
            button: true,
            enabled: true,
            child: ExcludeSemantics(
              child: SizedBox(
                width: _startColumnWidth,
                child: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: onRemoveCartItemPressed,
                  tooltip: web296TooltipRemoveItem,
                ),
              ),
            ),
          ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
