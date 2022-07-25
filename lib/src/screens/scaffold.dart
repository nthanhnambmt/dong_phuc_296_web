// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import '../routing.dart';
import 'scaffold_body.dart';

class DongPhuc296WebScaffold extends StatelessWidget {
  const DongPhuc296WebScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const DongPhuc296WebScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/product/clothing');
          if (idx == 1) routeState.go('/sizeList');
          if (idx == 2) routeState.go('/authors');
          if (idx == 3) routeState.go('/settings');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Sản phẩm',
            icon: Icons.book,
          ),
          AdaptiveScaffoldDestination(
            title: 'Hướng dẫn chọn size',
            icon: Icons.book_outlined,
          ),
          AdaptiveScaffoldDestination(
            title: 'Authors',
            icon: Icons.person,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/product')) return 0;
    if (pathTemplate == '/sizeList') return 1;
    if (pathTemplate == '/authors') return 2;
    if (pathTemplate == '/settings') return 3;
    return 0;
  }
}
