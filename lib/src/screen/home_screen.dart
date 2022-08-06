// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dongphuc296web/src/widgets/asymmetric_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/gallery_options.dart';
import '../layout/adaptive.dart';
import '../widgets/expanding_bottom_sheet.dart';
import '../data/model/app_state_model.dart';

const _ordinalSortKeyName = 'home';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    this.expandingBottomSheet,
    this.scrim,
    this.backdrop,
    super.key,
  });

  final ExpandingBottomSheet? expandingBottomSheet;
  final Widget? scrim;
  final Widget? backdrop;

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    // Use sort keys to make sure the cart button is always on the top.
    // This way, a11y users do not have to scroll through the entire list to
    // find the cart, and can easily get to the cart from anywhere on the page.
    return ApplyTextOptions(
      child: Stack(
        children: [
          Semantics(
            container: true,
            sortKey: const OrdinalSortKey(1, name: _ordinalSortKeyName),
            child: backdrop,
          ),
          ExcludeSemantics(child: scrim),
          Align(
            alignment: isDesktop
                ? AlignmentDirectional.topEnd
                : AlignmentDirectional.bottomEnd,
            child: Semantics(
              container: true,
              sortKey: const OrdinalSortKey(0, name: _ordinalSortKeyName),
              child: expandingBottomSheet,
            ),
          ),
        ],
      ),
    );
  }
}
