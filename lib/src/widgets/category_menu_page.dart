// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dong_phuc_296_web/src/layout/text_scale.dart';
import 'package:dong_phuc_296_web/src/data/model/product_model.dart';
import 'package:dong_phuc_296_web/src/widgets/page_status.dart';
import 'package:dong_phuc_296_web/src/widgets/web_296_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../data/gallery_options.dart';
import '../data/model/category_model.dart';
import '../layout/adaptive.dart';
import '../util/strings.dart';
import '../app.dart';
import '../util/colors.dart';
import '../data/model/app_state_model.dart';

double desktopCategoryMenuPageWidth({
  required BuildContext context,
}) {
  return 232 * reducedTextScale(context);
}

class CategoryMenuPage extends StatelessWidget {
  const CategoryMenuPage({
    super.key,
    this.onCategoryTap,
  });

  final VoidCallback? onCategoryTap;

  Widget _buttonText(String caption, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        caption,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _divider({required BuildContext context}) {
    return Container(
      width: 56 * GalleryOptions.of(context).textScaleFactor(context),
      height: 1,
      color: const Color(0xFF8F716D),
    );
  }

  Widget _buildCategory(CategoryModel category, BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    final categoryString = category.catName;

    final selectedCategoryTextStyle = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: isDesktop ? 17 : 19);

    final unselectedCategoryTextStyle = selectedCategoryTextStyle.copyWith(
        color: web296Brown900.withOpacity(0.6));

    final indicatorHeight = (isDesktop ? 28 : 30) *
        GalleryOptions.of(context).textScaleFactor(context);
    final indicatorWidth = indicatorHeight * 34 / 28;

    return ScopedModelDescendant<AppStateModel>(
      builder: (context, child, model) => Semantics(
        selected: model.selectedCategory == category,
        button: true,
        enabled: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              model.setCategory(category);
              if (onCategoryTap != null) {
                onCategoryTap!();
              }
            },
            child: model.selectedCategory == category
                ? _buttonText(categoryString, selectedCategoryTextStyle)
                : _buttonText(categoryString, unselectedCategoryTextStyle),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    final logoutTextStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: isDesktop ? 17 : 19,
          color: web296Brown900.withOpacity(0.6),
        );

    if (isDesktop) {
      return AnimatedBuilder(
        animation: PageStatus.of(context)!.cartController,
        builder: (context, child) => ExcludeSemantics(
          excluding: !menuPageIsVisible(context),
          child: Material(
            child: Container(
              color: bgCategory,
              width: desktopCategoryMenuPageWidth(context: context),
              child:
              ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 10),
                    Web296LogoWidget(isSmallText: true),
                    const SizedBox(height: 20),
                    ///Dùng Spacer bị lỗi Incorrect use of ParentDataWidget.
                    // const Spacer(),
                    for (final category in categories)
                      _buildCategory(category, context),
                    Semantics(
                      button: true,
                      enabled: true,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .restorablePushNamed(ShrineApp.contactUsRoute);
                          },
                          child: _buttonText(
                            web296CategoryNameContactUs,
                            logoutTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Semantics(
                      button: true,
                      enabled: true,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .restorablePushNamed(ShrineApp.introRoute);
                          },
                          child: _buttonText(
                            web296CategoryNameIntro,
                            logoutTextStyle,
                          ),
                        ),
                      ),
                    ),
                    _divider(context: context),
                    ///Đăng xuất
                    // Semantics(
                    //   button: true,
                    //   enabled: true,
                    //   child: MouseRegion(
                    //     cursor: SystemMouseCursors.click,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         Navigator.of(context)
                    //             .restorablePushNamed(ShrineApp.loginRoute);
                    //       },
                    //       child: _buttonText(
                    //         web296LogoutButtonCaption,
                    //         logoutTextStyle,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      tooltip: web296TooltipSearch,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 150),
                  ]),
            ),
          ),
        ),
      );
    } else {
      return AnimatedBuilder(
        animation: PageStatus.of(context)!.cartController,
        builder: (context, child) => AnimatedBuilder(
          animation: PageStatus.of(context)!.menuController,
          builder: (context, child) => ExcludeSemantics(
            excluding: !menuPageIsVisible(context),
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 40),
                color: bgCategory,
                child: ListView(
                  children: [
                    for (final category in categories)
                      _buildCategory(category, context),
                    Semantics(
                      button: true,
                      enabled: true,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            if (onCategoryTap != null) {
                              onCategoryTap!();
                            }
                            Navigator.of(context)
                                .restorablePushNamed(ShrineApp.contactUsRoute);
                          },
                          child: _buttonText(
                            web296CategoryNameContactUs,
                            logoutTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Semantics(
                      button: true,
                      enabled: true,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            if (onCategoryTap != null) {
                              onCategoryTap!();
                            }
                            Navigator.of(context)
                                .restorablePushNamed(ShrineApp.introRoute);
                          },
                          child: _buttonText(
                            web296CategoryNameIntro,
                            logoutTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: _divider(context: context),
                    ),
                    Semantics(
                      button: true,
                      enabled: true,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            if (onCategoryTap != null) {
                              onCategoryTap!();
                            }
                            Navigator.of(context)
                                .restorablePushNamed(ShrineApp.loginRoute);
                          },
                          child: _buttonText(
                            web296LogoutButtonCaption,
                            logoutTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
