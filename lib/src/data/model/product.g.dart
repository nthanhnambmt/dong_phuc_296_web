// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      catId: json['catId'] as int? ?? 1,
      catName: json['catName'] as String?,
      productId: json['productId'] as int? ?? 0,
      productName: json['productName'] as String?,
      productPrice: json['productPrice'] as int? ?? 0,
      assetAspectRatio: (json['assetAspectRatio'] as num?)?.toDouble() ?? 1.0,
      dateCreated: json['dateCreated'] as Timestamp?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'catId': instance.catId,
      'catName': instance.catName,
      'productId': instance.productId,
      'assetAspectRatio': instance.assetAspectRatio,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'dateCreated': instance.dateCreated,
    };
