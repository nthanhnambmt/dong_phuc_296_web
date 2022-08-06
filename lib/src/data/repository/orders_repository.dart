// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongphuc296web/src/data/model/order_model.dart';
import 'package:dongphuc296web/src/data/model/product_model.dart';
import 'package:dongphuc296web/src/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

import '../../util/constants.dart';
import '../../util/query_enum.dart';
import '../../util/utils.dart';
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

  ///Get list order
  ///await OrdersRepository().getListOrders(OrderQueryEnum.dateCreatedDesc);
  Future<List<OrderModel>> getListOrders(OrderQueryEnum queryEnum) async {
    try {
      await FirebaseFirestore.instance
          .collection(orderDocument)
          .queryBy(queryEnum, '')
          .get()
          .then((value) => {
                lstOrders = List.from(
                    value.docs.map((item) => OrderModel.fromSnapshot(item)))
              });

      lstOrders.forEach((element) {
        print(
            '------------------------CommonLog: lstOrders element ${element.toJson()}');
      });
    } catch (e) {
      print('------------------------CommonLog: lstOrders element error $e');
    }

    return lstOrders;
  }

  Future<OrderModel> getOrderDetail(int? orderId) async {
    return await FirebaseFirestore.instance
        .collection(orderDocument)
        .doc(orderId.valueOrZeroInt.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return OrderModel.fromSnapshot(documentSnapshot);
      } else {
        return OrderModel();
      }
    }).catchError((error) => OrderModel());
  }

  ///Document ID là auto-ID của firebase
  Future<void> addNewOrder(OrderModel newOrder) {
    return FirebaseFirestore.instance
        .collection(orderDocument)
        .add({
          'orderId': newOrder.orderId,
          'receiverName': newOrder.receiverName,
          'receiverPhone': newOrder.receiverPhone,
          'receiverAddress': newOrder.receiverAddress,
          'dateCreated': newOrder.dateCreated,
          'isDeleted': newOrder.isDeleted,
          'statusId': newOrder.status?.statusId.valueOrZeroInt,
        })
        .then((value) => print(
            "------------------------CommonLog: Order ${newOrder.orderId} Added"))
        .catchError((error) => print(
            "------------------------CommonLog: Failed to addNewOrder: $error"));
  }

  ///Set được Document ID
  Future<void> setNewOrder(BuildContext context, OrderModel newOrder) {
    return FirebaseFirestore.instance
        .collection(orderDocument)
        .doc(newOrder.orderId.toString())
        .set({
          'orderId': newOrder.orderId,
          'receiverName': newOrder.receiverName,
          'receiverPhone': newOrder.receiverPhone,
          'receiverAddress': newOrder.receiverAddress,
          'dateCreated': Timestamp.fromMicrosecondsSinceEpoch(
              newOrder.dateCreated!.microsecondsSinceEpoch.valueOrZeroInt),
          'isDeleted': newOrder.isDeleted,
          'statusId': newOrder.status?.statusId.valueOrZeroInt,
          'lstProducts': newOrder.toMapForSnapshot()['lstProducts'],
        })
        .then((value) =>
            Utils.showAlertDialog(context, 'Tạo đơn hàng thành công'))
        .catchError(
            (error) => Utils.showAlertDialog(context, 'Lỗi tạo đơn hàng'));
  }

  Future<void> updateOrder(OrderModel newOrder) {
    return FirebaseFirestore.instance
        .collection(orderDocument)
        .doc(newOrder.orderId.toString())
        .update({
          'orderId': newOrder.orderId,
          'receiverName': newOrder.receiverName,
          'receiverPhone': newOrder.receiverPhone,
          'receiverAddress': newOrder.receiverAddress,
          'dateCreated': newOrder.dateCreated,
          'isDeleted': newOrder.isDeleted,
          'statusId': newOrder.status?.statusId.valueOrZeroInt,
        })
        .then((value) => print(
            "------------------------CommonLog: Order ${newOrder.orderId} updated"))
        .catchError((error) => print(
            "------------------------CommonLog: Failed to updateOrder: $error"));
  }

  Future<void> deleteOrder(OrderModel orderModel) {
    return FirebaseFirestore.instance
        .collection(orderDocument)
        .doc(orderModel.orderId.toString())
        .delete()
        .then((value) => print(
            "------------------------CommonLog: Order ${orderModel.orderId} deleted"))
        .catchError((error) => print(
            "------------------------CommonLog: Failed to deleteOrder: $error"));
  }
}

extension on CollectionReference {
  /// Create a firebase query from a [OrderQueryEnum]
  Query<Object?> queryBy(OrderQueryEnum queryEnum, Object query) {
    switch (queryEnum) {
      case OrderQueryEnum.id:
        return where('orderId', isEqualTo: query)
            .where('isDeleted', isEqualTo: false);

      case OrderQueryEnum.dateCreatedDesc:
      case OrderQueryEnum.dateCreatedAsc:
        return orderBy('dateCreated',
                descending: query == OrderQueryEnum.dateCreatedDesc)
            .where('isDeleted', isEqualTo: false);
    }
  }
}
