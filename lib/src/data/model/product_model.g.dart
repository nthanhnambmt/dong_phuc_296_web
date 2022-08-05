// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      catId: json['catId'] as int? ?? 1,
      catName: json['catName'] as String?,
      productId: json['productId'] as int? ?? 0,
      productName: json['productName'] as String? ?? 'Không tên',
      productPrice: json['productPrice'] as int? ?? 0,
      assetAspectRatio: (json['assetAspectRatio'] as num?)?.toDouble() ?? 1.0,
      dateCreated: const TimeStampConverter()
          .fromJson(json['dateCreated'] as Timestamp?),
      isShow: json['isShow'] as bool? ?? true,
      quantity: json['quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'catId': instance.catId,
      'catName': instance.catName,
      'productId': instance.productId,
      'assetAspectRatio': instance.assetAspectRatio,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'dateCreated': const TimeStampConverter().toJson(instance.dateCreated),
      'isShow': instance.isShow,
      'quantity': instance.quantity,
    };
