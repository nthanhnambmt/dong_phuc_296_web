// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dong_phuc_296_web/src/data/model/order_model.dart';
import 'package:dong_phuc_296_web/src/data/model/status_model.dart';
import 'package:dong_phuc_296_web/src/util/constants.dart';
import 'package:dong_phuc_296_web/src/widgets/theme.dart';
import 'package:dong_phuc_296_web/src/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import '../data/model/app_state_model.dart';
import '../data/repository/orders_repository.dart';
import '../layout/letter_spacing.dart';
import '../util/colors.dart';
import '../util/query_enum.dart';
import '../util/strings.dart';
import '../util/utils.dart';
import 'cart_row_widget.dart';
import 'edit_text_widget.dart';
import 'expanding_bottom_sheet.dart';

const _startColumnWidth = 60.0;
const _ordinalSortKeyName = 'shopping_cart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final receiverNameController = TextEditingController();
  final receiverPhoneController = TextEditingController();
  final receiverAddressController = TextEditingController();

  //This key will be used to identify the state of the form.
  final formKey = GlobalKey<FormState>();

  List<Widget> _createShoppingCartRows(AppStateModel model) {
    return model.productsInCart.keys
        .map(
          (id) => CartRowWidget(
            product: model.getProductById(id),
            quantity: model.productsInCart[id],
            onRemoveCartItemPressed: () {
              model.removeItemFromCart(id);
            },
            onAddCartItemPressed: () {
              model.addProductToCart(id);
            },
            startColumnWidth: _startColumnWidth,
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    receiverNameController.dispose();
    receiverPhoneController.dispose();
    receiverAddressController.dispose();
    super.dispose();
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
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          buildShippingInfo(
                              context, model, expandingBottomSheet),
                          buildButtonOrder(
                              context, model, expandingBottomSheet),
                          const SizedBox(height: 20),
                          buildButtonClearCart(
                              context, model, expandingBottomSheet),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container buildShippingInfo(BuildContext context, AppStateModel model,
      ExpandingBottomSheetState? expandingBottomSheet) {
    final localTheme = Theme.of(context);

    return Container(
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        width: double.infinity,
        child: Semantics(
          sortKey: const OrdinalSortKey(3, name: _ordinalSortKeyName),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  receiverInfo,
                  style: localTheme.textTheme.subtitle1!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                EditTextWidget(
                  hintText: receiverName,
                  myController: receiverNameController,
                  validator: (val) {
                    if (!val.valueOrEmptyString().isValidName)
                      return '$enterValidText $receiverName';
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                EditTextWidget(
                  hintText: receiverPhone,
                  myController: receiverPhoneController,
                  validator: (val) {
                    if (!val.valueOrEmptyString().isValidPhone)
                      return '$enterValidText $receiverPhone hợp lệ';
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                EditTextWidget(
                  hintText: receiverAddress,
                  myController: receiverAddressController,
                  validator: (val) {
                    if (val.valueOrEmptyString().isEmpty)
                      return '$enterValidText $receiverAddress';
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  Container buildButtonOrder(BuildContext context, AppStateModel model,
      ExpandingBottomSheetState? expandingBottomSheet) {
    return Container(
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        width: double.infinity,
        child: Semantics(
          sortKey: const OrdinalSortKey(3, name: _ordinalSortKeyName),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              primary: web296Pink100,
            ),
            onPressed: () async {
              //TODO: Check data truoc khi gui, thong bao khi thanh cong
              // Utils.sendFCM(
              //   context,
              //   [fcm_token_nokia_2_3],
              //   OrderModel(
              //       receiverNameController.text,
              //       receiverPhoneController.text,
              //       receiverAddressController.text),
              //   () => {
              //     Utils.showTwoButtonDialog(context, cartClearQuestion, () {
              //       setState(() {
              //         Utils.showAlertDialog(context, orderSuccess);
              //         model.clearCart();
              //         expandingBottomSheet!.close();
              //       });
              //     })
              //   },
              // );

              ///Test cloud firestore
              // final ref = FirebaseFirestore.instance.collection(orderDocument);
              // ref.get().then((QuerySnapshot querySnapshot) {
              //   querySnapshot.docs.forEach((doc) {
              //     print(
              //         '------------------------CommonLog: Document data: ${doc.data()}');
              //   });
              // });
              print(
                  '------------------------CommonLog: formKey.currentState!.validate(): ${formKey.currentState!.validate()}');

              if (formKey.currentState!.validate()) {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => SuccessPage(),
                //   ),
                // );
                await OrdersRepository().setNewOrder(OrderModel(
                  orderId: DateTime.now().millisecondsSinceEpoch,
                  receiverName: receiverNameController.text,
                  receiverPhone: receiverPhoneController.text,
                  receiverAddress: receiverAddressController.text,
                  status:  StatusModel(statusId: 1, statusName: ''),
                  dateCreated: DateTime.now(),
                  isDeleted: false,
                ));
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                web296CartOrderButtonCaption,
                style: TextStyle(
                    letterSpacing: letterSpacingOrNone(largeLetterSpacing)),
              ),
            ),
          ),
        ));
  }

  Container buildButtonClearCart(BuildContext context, AppStateModel model,
      ExpandingBottomSheetState? expandingBottomSheet) {
    return Container(
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        width: double.infinity,
        child: Semantics(
          sortKey: const OrdinalSortKey(3, name: _ordinalSortKeyName),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              primary: web296Pink75,
            ),
            onPressed: () {
              Utils.showTwoButtonDialog(context, cartClearQuestion, () {
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
                    letterSpacing: letterSpacingOrNone(largeLetterSpacing)),
              ),
            ),
          ),
        ));
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
                // const SizedBox(height: 4),
                // MergeSemantics(
                //   child: Row(
                //     children: [
                //       SelectableText(
                //         web296CartTaxCaption,
                //       ),
                //       Expanded(
                //         child: SelectableText(
                //           formatter.format(model.tax),
                //           style: smallAmountStyle,
                //           textAlign: TextAlign.end,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
