// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong_phuc_296_web/src/data/model/order_model.dart';
import 'package:dong_phuc_296_web/src/data/model/product.dart';
import 'package:dong_phuc_296_web/src/extensions/extensions.dart';

import '../../util/product_query_enum.dart';
import '../model/category_model.dart';

class OrdersRepository {
  static final OrdersRepository _instance = OrdersRepository._internal();
  List<OrderModel> lstOrders = [];

  factory OrdersRepository() {
    return _instance;
  }

  OrdersRepository._internal() {
    // initialization logic
  }

  //TODO: chưa xong, làm tiếp với order
  // Future<List<OrderModel>> getListOrders(
  //     int categoryId, ProductQueryEnum queryEnum) async {
  //   if (lstOrders.isEmpty) {
  //     final data = await FirebaseFirestore.instance
  //         .collection('order')
  //         .queryBy(queryEnum, '')
  //         .get();
  //     lstOrders =
  //         List.from(data.docs.map((item) => OrderModel(receiverName, receiverPhone, receiverAddress).fromSnapshot(item)));
  //     lstOrders.forEach((element) {
  //       print('------------------------CommonLog: element ${element.toJson()}');
  //     });
  //   }
  //
  //   if (categoryId == categoryAll.catId) {
  //     return lstProducts;
  //   } else {
  //     return lstProducts.where((p) => p.catId == categoryId).toList();
  //   }
  // }

  Future<Product> getProductDetail(int? productId) async {
    return await FirebaseFirestore.instance
        .collection('product')
        .doc(productId.valueOrZeroInt.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return Product.fromSnapshot(documentSnapshot);
      } else {
        return Product();
      }
    }).catchError((error) => Product());
  }

  ///Document ID là auto-ID của firebase
  Future<void> addNewProduct(Product newProduct) {
    return FirebaseFirestore.instance
        .collection('product')
        .add({
          'catId': newProduct.catId,
          'catName': newProduct.catName,
          'productId': newProduct.productId,
          'productName': newProduct.productName,
          'productPrice': newProduct.productPrice,
          'assetAspectRatio': newProduct.assetAspectRatio,
          'dateCreated': newProduct.dateCreated,
        })
        .then((value) => print("Product ${newProduct.productName} Added"))
        .catchError((error) => print("Failed to add Product: $error"));
  }

  ///Set được Document ID
  Future<void> setNewProduct(Product newProduct) {
    return FirebaseFirestore.instance
        .collection('product')
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
        .then((value) => print("Product ${newProduct.productName} Added"))
        .catchError((error) => print("Failed to add Product: $error"));
  }

  Future<void> updateProduct(Product newProduct) {
    return FirebaseFirestore.instance
        .collection('product')
        .doc(newProduct.productId.toString())
        .update({
          'catId': newProduct.catId,
          'catName': newProduct.catName,
          'productId': newProduct.productId,
          'productName': newProduct.productName,
          'productPrice': newProduct.productPrice,
          'assetAspectRatio': newProduct.assetAspectRatio,
        })
        .then((value) => print("Product ${newProduct.productName} Added"))
        .catchError((error) => print("Failed to add Product: $error"));
  }

  Future<void> deleteProduct(Product product) {
    return FirebaseFirestore.instance
        .collection('product')
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
