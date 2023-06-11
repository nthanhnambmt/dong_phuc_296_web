// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';
import 'dart:js';

import 'package:dongphuc296web/src/data/model/account_model.dart';
import 'package:dongphuc296web/src/data/model/order_model.dart';
import 'package:dongphuc296web/src/data/model/product_model.dart';
import 'package:dongphuc296web/src/data/repository/orders_repository.dart';
import 'package:dongphuc296web/src/data/repository/products_repository.dart';
import 'package:dongphuc296web/src/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../app.dart';
import '../../util/constants.dart';
import '../../util/query_enum.dart';
import '../../util/strings.dart';
import '../../util/utils.dart';
import '../repository/account_repository.dart';
import 'category_model.dart';

class AppStateModel extends Model {
  bool loggedin = true;
  AccountModel _accountLoggedin = AccountModel();

  // All the available products.
  List<ProductModel> _availableProducts = [];
  List<OrderModel> _availableOrders = [];

  // The currently selected category of products.
  CategoryModel _selectedCategory = categoryAll;

  // The IDs and quantities of products currently in the cart.
  final Map<int, int> _productsInCart = <int, int>{};
  final List<ProductModel> lstProductInCart = [];

  Map<int, int> get productsInCart => Map<int, int>.from(_productsInCart);

  // Total number of items in the cart.
  int get totalCartQuantity => _productsInCart.values.fold(0, (v, e) => v + e);

  CategoryModel get selectedCategory => _selectedCategory;

  // Totaled prices of the items in the cart.
  double get subtotalCost {
    return _productsInCart.keys
        .map((id) =>
            lstProductInCart
                .firstWhere((element) => element.productId == id)
                .productPrice
                .valueOrZeroInt *
            _productsInCart[id]!)
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
  void addProductToCart(ProductModel productModel) {
    int productId = productModel.productId.valueOrZeroInt;
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;

      ///Update lstProductInCart
      lstProductInCart.add(productModel..quantity = 1);
    } else {
      _productsInCart[productId] = _productsInCart[productId]! + 1;

      ///Update lstProductInCart
      var productNeedUpdate =
          lstProductInCart.firstWhere((p) => p.productId == productId);
      productNeedUpdate
        ..quantity = productNeedUpdate.quantity.valueOrZeroInt + 1;
    }
    lstProductInCart.forEach((element) {
      print(
          '---------------->>>>>>>>>>>>>>>>>>>>>>lstProductInCart    ${element.toJson()}');
    });
    _productsInCart.forEach((key, value) {
      print(
          '---------------->>>>>>>>>>>>>>>>>>>>>>_productsInCart $key --    $value');
    });

    _availableProducts.forEach((element) {
      print(
          '---------------->>>>>>>>>>>>>>>>>>>>>>_availableProducts    ${element.toJson()}');
    });
    print('---------------->>>>>>>>>>>>>>>>>>>>>>totalCost $totalCost');
    notifyListeners();
  }

  // Adds products to the cart by a certain amount.
  // quantity must be non-null positive value.
  void addMultipleProductsToCart(int productId, int quantity) {
    assert(quantity > 0);
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = quantity;

      ///Update lstProductInCart
      lstProductInCart.add(getProductById(productId)..quantity = quantity);
    } else {
      _productsInCart[productId] = _productsInCart[productId]! + quantity;

      ///Update lstProductInCart
      var productNeedUpdate =
          lstProductInCart.firstWhere((p) => p.productId == productId);
      productNeedUpdate
        ..quantity = productNeedUpdate.quantity.valueOrZeroInt + quantity;
    }

    notifyListeners();
  }

  // Removes an item from the cart.
  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);

        ///Update lstProductInCart
        lstProductInCart
            .removeWhere((element) => element.productId == productId);
      } else {
        _productsInCart[productId] = _productsInCart[productId]! - 1;

        ///Update lstProductInCart
        var productNeedUpdate =
            lstProductInCart.firstWhere((p) => p.productId == productId);
        productNeedUpdate
          ..quantity = productNeedUpdate.quantity.valueOrZeroInt - 1;
      }
    }

    notifyListeners();
  }

  // Returns the Product instance matching the provided id.
  ProductModel getProductById(int id) {
    return _availableProducts.firstWhere((p) => p.productId == id);
  }

  // Get all product in cart.
  List<ProductModel> getProductInCart() {
    return lstProductInCart;
  }

  // Removes everything from the cart.
  void clearCart() {
    _productsInCart.clear();
    lstProductInCart.clear();
    notifyListeners();
  }

  // Loads the list of available products from the repo.
  Future<void> loadProducts() async {
    _availableProducts = await ProductsRepository()
        .getListProducts(categoryAll.catId, ProductQueryEnum.dateCreatedDesc);
    notifyListeners();
  }

  Future<void> loadListOrders() async {
    _availableOrders =
        await OrdersRepository().getListOrders(OrderQueryEnum.dateCreatedDesc);
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

  Future<void> logOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    loggedin = false;
    notifyListeners();
  }

  Future<bool> logIn(AccountModel loginAccount, BuildContext context) async {
    print(
        '---------------->>>>>>>>>>>>>>>>>>>>>>logIn    ${loginAccount.toJson()}');

    _accountLoggedin = await AccountRepository().loginAccount(loginAccount);

    // Check Sign in result.
    if (_accountLoggedin.registerCode == web296LoginCodeFailUserName) {
      loggedin = false;
      Utils.showAlertDialog(context, web296LoginFailUserName);
    } else {
      if (_accountLoggedin.password == loginAccount.password) {
        loggedin = true;
        Navigator.of(context).restorablePushNamed(Web296App.homeRoute);
      } else
        Utils.showAlertDialog(context, web296LoginFailPassword);
    }

    notifyListeners();
    return loggedin;
  }

  Future<bool> registerAccount(
      AccountModel registerAccount, BuildContext context) async {
    print(
        '---------------->>>>>>>>>>>>>>>>>>>>>>registerAccount    ${registerAccount.toJson()}');

    _accountLoggedin =
        await AccountRepository().registerAccount(registerAccount);

    // Check Sign in result.
    if (_accountLoggedin.registerCode == web296RegisterCodeFailAccountExists) {
      loggedin = false;
      Utils.showAlertDialog(context, web296AccountExists);
    } else if (_accountLoggedin.registerCode == web296RegisterCodeFail) {
      loggedin = false;
      Utils.showAlertDialog(context, web296RegisterCodeFail);
    } else {
      loggedin = true;
      Navigator.of(context).restorablePushNamed(Web296App.homeRoute);
    }

    notifyListeners();
    return loggedin;
  }
}
