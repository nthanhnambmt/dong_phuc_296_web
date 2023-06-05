// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'converter/TimeStampConverter.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  // final CategoryModel category;
  @JsonKey(name: 'catId', defaultValue: 1)
  int? catId;
  @JsonKey(name: 'catName')
  String? catName;
  @JsonKey(name: 'productId', defaultValue: 0)
  int? productId;
  @JsonKey(name: 'assetAspectRatio', defaultValue: 1.0)
  double? assetAspectRatio;
  @JsonKey(name: 'productName', defaultValue: 'Không tên')
  String? productName;
  @JsonKey(name: 'productPrice', defaultValue: 0)
  int? productPrice;
  @JsonKey(name: 'dateCreated')
  @TimeStampConverter()
  DateTime? dateCreated;
  @JsonKey(name: 'isShow', defaultValue: true)
  bool? isShow;
  @JsonKey(name: 'quantity', defaultValue: 0)
  int? quantity;

  ProductModel({
    this.catId,
    this.catName,
    this.productId,
    this.productName,
    this.productPrice,
    this.assetAspectRatio,
    this.dateCreated,
    this.isShow,
    this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  int getProductSubTotal(int? quantity) {
    int _quantity = quantity != null ? quantity : 0;
    return this.productPrice != null ? this.productPrice! * _quantity : 0;
  }

  ProductModel.fromSnapshot(snapshot)
      : catId = snapshot.data()['catId'],
        catName = snapshot.data()['catName'],
        productId = snapshot.data()['productId'],
        productName = snapshot.data()['productName'],
        productPrice = snapshot.data()['productPrice'],
        assetAspectRatio = snapshot.data()['assetAspectRatio'],
        dateCreated =
            const TimeStampConverter().fromJson(snapshot.data()['dateCreated']);

  ProductModel.fromSnapshotForOrder(Map<String, dynamic> map)
      : productId = map['productId'],
        productName = map['productName'],
        productPrice = map['productPrice'],
        quantity = map['quantity'];

  Map<String, dynamic> toMapForSnapshot() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
    };
  }

  String get getThumbNailName => '0.jpg';
  String get getThumbNailFolder => 'product_images/$productId';

  String get getFullImageFolder => 'product_images/$productId/full';
}
