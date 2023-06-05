// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dongphuc296web/src/extensions/extensions.dart';
import 'package:dongphuc296web/src/widgets/theme.dart';
import 'package:dongphuc296web/src/widgets/web_296_logo_widget.dart';
import 'package:flutter/material.dart';
import '../../data/gallery_options.dart';
import '../../data/model/product_model.dart';
import '../../data/repository/products_repository.dart';
import '../../layout/adaptive.dart';
import '../../layout/letter_spacing.dart';
import '../../util/constants.dart';
import '../../util/strings.dart';
import '../../util/utils.dart';
import '../../widgets/edit_text_widget.dart';

class AdminListOrdersScreen extends StatefulWidget {
  const AdminListOrdersScreen({super.key});

  @override
  State<AdminListOrdersScreen> createState() => AdminListOrdersScreenState();
}

class AdminListOrdersScreenState extends State<AdminListOrdersScreen> {
  final productIdController = TextEditingController();
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productAspectRatioController = TextEditingController();
  final productCatIdController = TextEditingController();
  final productCatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return ApplyTextOptions(
      child: isDesktop
          ? LayoutBuilder(
              builder: (context, constraints) => Scaffold(
                body: SafeArea(
                  child: Center(
                    child: SizedBox(
                      width: Utils.desktopLoginScreenMainAreaWidth(
                          context: context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Web296LogoWidget(),
                          SizedBox(height: 20),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: strProductId,
                            myController: productIdController,
                          ),
                          SizedBox(height: 16),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: strProductName,
                            myController: productNameController,
                          ),
                          SizedBox(height: 16),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: strProductPrice,
                            myController: productPriceController,
                          ),
                          SizedBox(height: 16),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: strProductAspectRatio,
                            myController: productAspectRatioController,
                          ),
                          SizedBox(height: 16),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: strProductCategoryId,
                            myController: productCatIdController,
                          ),
                          SizedBox(height: 16),
                          EditTextWidget(
                            isReadOnly: false,
                            hintText: strProductCategoryName,
                            myController: productCatController,
                          ),
                          SizedBox(height: 24),
                          _CancelAndNextButtons(createProductModel()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              body: SafeArea(
                child: ListView(
                  restorationId: 'login_list_view',
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  children: [
                    SizedBox(height: 20),
                    Web296LogoWidget(),
                    SizedBox(height: 20),
                    EditTextWidget(
                      isReadOnly: false,
                      hintText: strProductId,
                      myController: productIdController,
                    ),
                    SizedBox(height: 16),
                    EditTextWidget(
                      isReadOnly: false,
                      hintText: strProductName,
                      myController: productNameController,
                    ),
                    SizedBox(height: 16),
                    EditTextWidget(
                      isReadOnly: false,
                      hintText: strProductPrice,
                      myController: productPriceController,
                    ),
                    SizedBox(height: 16),
                    EditTextWidget(
                      isReadOnly: false,
                      hintText: strProductAspectRatio,
                      myController: productAspectRatioController,
                    ),
                    SizedBox(height: 16),
                    EditTextWidget(
                      isReadOnly: false,
                      hintText: strProductCategoryId,
                      myController: productCatIdController,
                    ),
                    SizedBox(height: 16),
                    EditTextWidget(
                      isReadOnly: false,
                      hintText: strProductCategoryName,
                      myController: productCatController,
                    ),
                    SizedBox(height: 24),
                    _CancelAndNextButtons(createProductModel()),
                  ],
                ),
              ),
            ),
    );
  }

  ProductModel createProductModel() {
    return ProductModel(
      productId: productIdController.text.toInt,
      productName: productNameController.text,
      productPrice: productPriceController.text.toInt,
      assetAspectRatio: double.tryParse(productAspectRatioController.text),
      catId: productCatIdController.text.toInt,
      catName: productCatController.text,
      dateCreated: DateTime.now(),
      isShow: true,
    );
  }
}

class _CancelAndNextButtons extends StatelessWidget {
  const _CancelAndNextButtons(this.productModel);

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isDesktop = isDisplayDesktop(context);

    final buttonTextPadding = isDesktop
        ? const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
        : EdgeInsets.zero;

    return Padding(
      padding: isDesktop ? EdgeInsets.zero : const EdgeInsets.all(8),
      child: OverflowBar(
        spacing: isDesktop ? 0 : 8,
        alignment: MainAxisAlignment.end,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            onPressed: () {
              // The login screen is immediately displayed on top of
              // the Shrine home screen using onGenerateRoute and so
              // rootNavigator must be set to true in order to get out
              // of Shrine completely.

              // Navigator.of(context, rootNavigator: true).pop();
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                web296CancelButtonCaption,
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            onPressed: () async {
              if (productModel != null) {
                await ProductsRepository()
                    .setNewProduct(context, productModel!);
              }
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                createProductButton,
                style: TextStyle(
                    letterSpacing: letterSpacingOrNone(largeLetterSpacing)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
