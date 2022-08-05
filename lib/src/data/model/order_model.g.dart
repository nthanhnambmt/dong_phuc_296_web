// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json['orderId'] as int?,
      receiverName: json['receiverName'] as String? ?? '',
      receiverPhone: json['receiverPhone'] as String? ?? '',
      receiverAddress: json['receiverAddress'] as String? ?? '',
      dateCreated: const TimeStampConverter()
          .fromJson(json['dateCreated'] as Timestamp?),
      isDeleted: json['isDeleted'] as bool? ?? false,
      status: json['status'] == null
          ? null
          : StatusModel.fromJson(json['status'] as Map<String, dynamic>),
      lstProducts: (json['lstProducts'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'receiverName': instance.receiverName,
      'receiverPhone': instance.receiverPhone,
      'receiverAddress': instance.receiverAddress,
      'dateCreated': const TimeStampConverter().toJson(instance.dateCreated),
      'isDeleted': instance.isDeleted,
      'status': instance.status,
      'lstProducts': instance.lstProducts,
    };
