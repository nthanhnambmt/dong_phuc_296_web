// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dong_phuc_296_web/src/data/model/product.dart';

import '../../util/strings.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    final allProducts = [
      Product(
        category: categoryPrint,
        id: 0,
        isFeatured: true,
        name: (context) => inBenHongAo,
        price: 50000,
        assetAspectRatio: 211 / 199,
      ),
      Product(
        category: categorySport,
        id: 1,
        isFeatured: true,
        name: (context) => aoBongBan,
        price: 180000,
        assetAspectRatio: 514 / 680,
      ),
      Product(
        category: categorySport,
        id: 2,
        isFeatured: true,
        name: (context) => aoBongBan,
        price: 180000,
        assetAspectRatio: 582 / 793,
      ),
      Product(
        category: categoryCanvas,
        id: 3,
        isFeatured: true,
        name: (context) => tuiCanVas,
        price: 120000,
        assetAspectRatio: 310 / 413,
      ),
      Product(
        category: categoryCanvas,
        id: 4,
        isFeatured: true,
        name: (context) => tuiCanVas,
        price: 120000,
        assetAspectRatio: 273 / 405,
      ),
      Product(
        category: categoryCanvas,
        id: 5,
        isFeatured: true,
        name: (context) => tuiCanVas,
        price: 120000,
        assetAspectRatio: 273 / 442,
      ),
      Product(
        category: categoryCanvas,
        id: 6,
        isFeatured: true,
        name: (context) => tuiCanVas,
        price: 120000,
        assetAspectRatio: 253 / 415,
      ),
      Product(
        category: categoryUniform,
        id: 7,
        isFeatured: true,
        name: (context) => aoPoloNam,
        price: 140000,
        assetAspectRatio: 305 / 419,
      ),
      Product(
        category: categoryUniform,
        id: 8,
        isFeatured: true,
        name: (context) => aoPoloNam,
        price: 160000,
        assetAspectRatio: 251 / 406,
      ),
      Product(
        category: categoryUniform,
        id: 9,
        isFeatured: true,
        name: (context) => aoPoloNu,
        price: 150000,
        assetAspectRatio: 326 / 348,
      ),
      Product(
        category: categoryUniform,
        id: 10,
        isFeatured: false,
        name: (context) => aoPoloNam,
        price: 150000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryPrint,
        id: 11,
        isFeatured: false,
        name: (context) => inHinh3040,
        price: 40000,
        assetAspectRatio: 329 / 246,
      ),
    ];
    if (category == categoryAll) {
      return allProducts;
    } else {
      return allProducts.where((p) => p.category == category).toList();
    }
  }
}
