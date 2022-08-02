// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
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
  Timestamp? dateCreated;
  @JsonKey(name: 'isShow', defaultValue: true)
  bool? isShow;

  Product({
    this.catId,
    this.catName,
    this.productId,
    this.productName,
    this.productPrice,
    this.assetAspectRatio,
    this.dateCreated,
    this.isShow,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  int getProductSubTotal(int? quantity) {
    int _quantity = quantity != null ? quantity : 0;
    return this.productPrice != null ? this.productPrice! * _quantity : 0;
  }

  Product.fromSnapshot(snapshot)
      : catId = snapshot.data()['catId'],
        catName = snapshot.data()['catName'],
        productId = snapshot.data()['productId'],
        productName = snapshot.data()['productName'],
        productPrice = snapshot.data()['productPrice'],
        assetAspectRatio = snapshot.data()['assetAspectRatio'],
        dateCreated = snapshot.data()['dateCreated'];

  String get getImageName => '$productId.jpg';

  String get getThumbNail => 'product_images';

  String get getImage2x => 'product_images/2x';

  String get getImage3x => 'product_images/3x';

}
