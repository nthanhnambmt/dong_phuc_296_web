// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:dong_phuc_296_web/src/data/model/order_model.dart';
import 'package:dong_phuc_296_web/src/data/model/product_model.dart';
import 'package:dong_phuc_296_web/src/data/repository/orders_repository.dart';
import 'package:dong_phuc_296_web/src/data/repository/products_repository.dart';
import 'package:dong_phuc_296_web/src/extensions/extensions.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../util/constants.dart';
import '../../util/query_enum.dart';
import 'category_model.dart';

class AppStateModel extends Model {
  // All the available products.
  List<ProductModel> _availableProducts = [];
  List<OrderModel> _availableOrders = [];

  // The currently selected category of products.
  CategoryModel _selectedCategory = categoryAll;

  // The IDs and quantities of products currently in the cart.
  final Map<int, int> _productsInCart = <int, int>{};

  Map<int, int> get productsInCart => Map<int, int>.from(_productsInCart);

  // Total number of items in the cart.
  int get totalCartQuantity => _productsInCart.values.fold(0, (v, e) => v + e);

  CategoryModel get selectedCategory => _selectedCategory;

  // Totaled prices of the items in the cart.
  double get subtotalCost {
    return _productsInCart.keys
        .map((id) => _availableProducts[id].productPrice.valueOrZeroInt * _productsInCart[id]!)
        .fold(0.0, (sum, e) => sum + e);
  }

  // Total shipping cost for the items in the cart.
  double get shippingCost {
    // return shippingFeeCostPerItem *
    //     _productsInCart.values.fold(0.0, (sum, e) => sum + e);
    return shippingFee;
  }

  // Sales tax for the items in the cart
  double get tax => subtotalCost * salesTaxRate;

  // Total cost to order everything in the cart.
  double get totalCost => subtotalCost + shippingCost + tax;

  // Returns a copy of the list of available products, filtered by category.
  List<ProductModel> getProducts() {
    if (_selectedCategory == categoryAll) {
      return List<ProductModel>.from(_availableProducts);
    } else {
      return _availableProducts
          .where((p) => p.catId == _selectedCategory.catId)
          .toList();
    }
  }

  // Adds a product to the cart.
  void addProductToCart(int productId) {
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;
    } else {
      _productsInCart[productId] = _productsInCart[productId]! + 1;
    }

    notifyListeners();
  }

  // Adds products to the cart by a certain amount.
  // quantity must be non-null positive value.
  void addMultipleProductsToCart(int productId, int quantity) {
    assert(quantity > 0);
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = quantity;
    } else {
      _productsInCart[productId] = _productsInCart[productId]! + quantity;
    }

    notifyListeners();
  }

  // Removes an item from the cart.
  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId] = _productsInCart[productId]! - 1;
      }
    }

    notifyListeners();
  }

  // Returns the Product instance matching the provided id.
  ProductModel getProductById(int id) {
    return _availableProducts.firstWhere((p) => p.productId == id);
  }

  // Removes everything from the cart.
  void clearCart() {
    _productsInCart.clear();
    notifyListeners();
  }

  // Loads the list of available products from the repo.
  Future<void> loadProducts() async {
    _availableProducts = await ProductsRepository().getListProducts(categoryAll.catId, ProductQueryEnum.dateCreatedDesc);
    notifyListeners();
  }

  Future<void> loadListOrders() async {
    _availableOrders = await OrdersRepository().getListOrders(OrderQueryEnum.dateCreatedDesc);
    notifyListeners();
  }

  void setCategory(CategoryModel newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }

  @override
  String toString() {
    return 'AppStateModel(totalCost: $totalCost)';
  }
}
