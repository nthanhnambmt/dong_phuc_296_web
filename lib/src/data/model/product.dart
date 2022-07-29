// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../util/strings.dart';

class Category {
  const Category({
    required this.name,
  });

  // A function taking a BuildContext as input and
  // returns the internationalized name of the category.
  final String Function(BuildContext) name;
}

Category categoryAll = Category(
  name: (context) => web296CategoryNameAll,
);

Category categoryAccessories = Category(
  name: (context) => web296CategoryNameAccessories,
);

Category categoryClothing = Category(
  name: (context) => web296CategoryNameClothing,
);

Category categoryHome = Category(
  name: (context) => web296CategoryNameHome,
);

List<Category> categories = [
  categoryAll,
  categoryAccessories,
  categoryClothing,
  categoryHome,
];

class Product {
  const Product({
    required this.category,
    required this.id,
    required this.isFeatured,
    required this.name,
    required this.price,
    this.assetAspectRatio = 1,
  });

  final Category category;
  final int id;
  final bool isFeatured;
  final double assetAspectRatio;

  // A function taking a BuildContext as input and
  // returns the internationalized name of the product.
  final String Function(BuildContext) name;

  final int price;

  int getProductSubTotal(int? quantity) {
    int _quantity = quantity != null ? quantity : 0;
    return this.price * _quantity;
  }

  String get getImageName => '$id-0.jpg';

  String get getThumbNail => 'product_images';

  String get getImage2x => 'product_images/2x';

  String get getImage3x => 'product_images/3x';
}
