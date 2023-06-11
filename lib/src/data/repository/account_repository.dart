// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongphuc296web/src/data/model/product_model.dart';
import 'package:dongphuc296web/src/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

import '../../util/constants.dart';
import '../../util/query_enum.dart';
import '../../util/strings.dart';
import '../../util/utils.dart';
import '../model/account_model.dart';
import '../model/category_model.dart';

class AccountRepository {
  static final AccountRepository _instance = AccountRepository._internal();
  AccountModel accountSigned = AccountModel();

  factory AccountRepository() {
    return _instance;
  }

  AccountRepository._internal() {
    // initialization logic
  }

  Future<AccountModel> registerAccount(AccountModel accountRegister) async {
    return await FirebaseFirestore.instance
        .collection(accountDocument)
        .doc(accountRegister.userName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return AccountModel(registerCode: web296RegisterCodeFailAccountExists);
      } else {
        FirebaseFirestore.instance
            .collection(accountDocument)
            .doc(accountRegister.userName)
            .set({
              'fullName': accountRegister.fullName,
              'userName': accountRegister.userName,
              'password': accountRegister.password,
              'registerCode': accountRegister.registerCode,
            })
            .then((value) => print(
                "------------------------accountRegister: ${accountRegister.userName} Added"))
            .catchError((error) => print(
                "------------------------CommonLog: Failed to add accountRegister: $error"));
        return accountRegister;
      }
    }).catchError(
            (error) => AccountModel(registerCode: web296RegisterCodeFail));
  }

  Future<AccountModel> loginAccount(AccountModel accountLogin) async {
    return await FirebaseFirestore.instance
        .collection(accountDocument)
        .doc(accountLogin.userName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return AccountModel.fromSnapshot(documentSnapshot);
      } else {
        return AccountModel(registerCode: web296LoginCodeFailUserName);
      }
    }).catchError(
            (error) => AccountModel(registerCode: web296LoginCodeFailUserName));
  }

  ///Document ID là auto-ID của firebase
  // Future<void> registerAccount(AccountModel accountRegister) {
  //
  //   return FirebaseFirestore.instance
  //       .collection(accountDocument)
  //       .add({
  //         'catId': newProduct.catId,
  //         'catName': newProduct.catName,
  //         'productId': newProduct.productId,
  //         'productName': newProduct.productName,
  //         'productPrice': newProduct.productPrice,
  //         'assetAspectRatio': newProduct.assetAspectRatio,
  //         'dateCreated': newProduct.dateCreated,
  //       })
  //       .then((value) => print(
  //           "------------------------CommonLog: Product ${newProduct.productName} Added"))
  //       .catchError((error) => print(
  //           "------------------------CommonLog: Failed to add Product: $error"));
  // }

  ///Set được Document ID
  Future<void> setNewProduct(BuildContext context, ProductModel newProduct) {
    return FirebaseFirestore.instance
        .collection(productDocument)
        .doc(newProduct.productId.toString())
        .set({
          'catId': newProduct.catId,
          'catName': newProduct.catName,
          'productId': newProduct.productId,
          'productName': newProduct.productName,
          'productPrice': newProduct.productPrice,
          'assetAspectRatio': newProduct.assetAspectRatio,
          'dateCreated': Timestamp.fromMicrosecondsSinceEpoch(
              newProduct.dateCreated!.microsecondsSinceEpoch.valueOrZeroInt),
        })
        .then((value) => Utils.showAlertDialog(
            context, 'Add product ${newProduct.productName} success'))
        .catchError((error) =>
            Utils.showAlertDialog(context, 'Failed to set Product: $error'));
  }

  Future<void> updateProduct(ProductModel newProduct) {
    return FirebaseFirestore.instance
        .collection(productDocument)
        .doc(newProduct.productId.toString())
        .update({
          'catId': newProduct.catId,
          'catName': newProduct.catName,
          'productId': newProduct.productId,
          'productName': newProduct.productName,
          'productPrice': newProduct.productPrice,
          'assetAspectRatio': newProduct.assetAspectRatio,
        })
        .then((value) => print("Product ${newProduct.productName} updated"))
        .catchError((error) => print("Failed to update Product: $error"));
  }

  Future<void> deleteProduct(ProductModel product) {
    return FirebaseFirestore.instance
        .collection(productDocument)
        .doc(product.productId.toString())
        .delete()
        .then((value) => print("Product ${product.productName} deleted"))
        .catchError((error) => print("Failed to delete Product: $error"));
  }
}

extension on CollectionReference {
  /// Create a firebase query from a [ProductQueryEnum]
  Query<Object?> queryBy(ProductQueryEnum queryEnum, Object query) {
    switch (queryEnum) {
      case ProductQueryEnum.name:
        return where('productName', isEqualTo: query)
            .where('isShow', isEqualTo: true);

      case ProductQueryEnum.categoryId:
        return where('catId', isEqualTo: query)
            .where('isShow', isEqualTo: true);

      case ProductQueryEnum.id:
        return where('productId', isEqualTo: query)
            .where('isShow', isEqualTo: true);

      case ProductQueryEnum.dateCreatedDesc:
        return orderBy('dateCreated', descending: true)
            .where('isShow', isEqualTo: true);

      case ProductQueryEnum.priceAsc:
      case ProductQueryEnum.priceDesc:
        return orderBy('productPrice',
                descending: query == ProductQueryEnum.priceDesc)
            .where('isShow', isEqualTo: true);
    }
  }
}
