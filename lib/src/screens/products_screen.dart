// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/product_list.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPath = _routeState.route.pathTemplate;
    if (newPath.startsWith('/product/clothing')) {
      _tabController.index = 0;
    } else if (newPath.startsWith('/product/canvas')) {
      _tabController.index = 1;
    } else if (newPath == '/product/all') {
      _tabController.index = 2;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF72cabe),
          toolbarHeight: 0,
          // title: const Text('Đồng phục 296'),
          bottom: TabBar(
            // labelColor: Colors.amber,
            indicatorColor: Colors.black,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Quần-Áo',
                icon: Icon(Icons.girl_sharp),
              ),
              Tab(
                text: 'Túi canvas',
                icon: Icon(Icons.cases_outlined),
                // icon: Icon(Icons.work_sharp),
              ),
              Tab(
                text: 'All',
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),

        // appBar: TabBar(
        //   labelColor: Colors.amber,
        //   indicatorColor: Colors.cyan,
        //   controller: _tabController,
        //   tabs: const [
        //     Tab(
        //       text: 'Quần-Áo',
        //       icon: Icon(Icons.girl_sharp),
        //     ),
        //     Tab(
        //       text: 'Túi canvas',
        //       icon: Icon(Icons.cases_outlined),
        //       // icon: Icon(Icons.work_sharp),
        //     ),
        //     Tab(
        //       text: 'All',
        //       icon: Icon(Icons.list),
        //     ),
        //   ],
        // ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ProductList(
              lstProduct: libraryInstance.popularBooks,
              onTap: _handleBookTapped,
            ),
            ProductList(
              lstProduct: libraryInstance.newBooks,
              onTap: _handleBookTapped,
            ),
            ProductList(
              lstProduct: libraryInstance.allBooks,
              onTap: _handleBookTapped,
            ),
          ],
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handleBookTapped(Product book) {
    _routeState.go('/book/${book.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 1:
        _routeState.go('/product/canvas');
        break;
      case 2:
        _routeState.go('/product/all');
        break;
      case 0:
      default:
        _routeState.go('/product/clothing');
        break;
    }
  }
}
