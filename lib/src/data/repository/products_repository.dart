// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong_phuc_296_web/src/data/model/product_model.dart';
import 'package:dong_phuc_296_web/src/extensions/extensions.dart';

import '../../util/constants.dart';
import '../../util/query_enum.dart';
import '../model/category_model.dart';

class ProductsRepository {
  static final ProductsRepository _instance = ProductsRepository._internal();
  List<ProductModel> lstProducts = [];

  factory ProductsRepository() {
    return _instance;
  }

  ProductsRepository._internal() {
    // initialization logic
  }

  Future<List<ProductModel>> getListProducts(
      int categoryId, ProductQueryEnum queryEnum) async {
    if (lstProducts.isEmpty) {
      final data = await FirebaseFirestore.instance
          .collection(productDocument)
          .queryBy(queryEnum, '')
          .get()
          .then((value) => {
                lstProducts = List.from(
                    value.docs.map((item) => ProductModel.fromSnapshot(item)))
              });
      // lstProducts =
      //     List.from(data.docs.map((item) => ProductModel.fromSnapshot(item)));
      lstProducts.forEach((element) {
        print('------------------------CommonLog: element ${element.toJson()}');
      });
    }

    if (categoryId == categoryAll.catId) {
      return lstProducts;
    } else {
      return lstProducts.where((p) => p.catId == categoryId).toList();
    }
  }

  Future<ProductModel> getProductDetail(int? productId) async {
    return await FirebaseFirestore.instance
        .collection(productDocument)
        .doc(productId.valueOrZeroInt.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return ProductModel.fromSnapshot(documentSnapshot);
      } else {
        return ProductModel();
      }
    }).catchError((error) => ProductModel());
  }

  ///Document ID là auto-ID của firebase
  Future<void> addNewProduct(ProductModel newProduct) {
    return FirebaseFirestore.instance
        .collection(productDocument)
        .add({
          'catId': newProduct.catId,
          'catName': newProduct.catName,
          'productId': newProduct.productId,
          'productName': newProduct.productName,
          'productPrice': newProduct.productPrice,
          'assetAspectRatio': newProduct.assetAspectRatio,
          'dateCreated': newProduct.dateCreated,
        })
        .then((value) => print("------------------------CommonLog: Product ${newProduct.productName} Added"))
        .catchError((error) => print("------------------------CommonLog: Failed to add Product: $error"));
  }

  ///Set được Document ID
  Future<void> setNewProduct(ProductModel newProduct) {
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
          'dateCreated': newProduct.dateCreated,
        })
        .then((value) => print("------------------------CommonLog: Product ${newProduct.productName} set"))
        .catchError((error) => print("------------------------CommonLog: Failed to set Product: $error"));
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
