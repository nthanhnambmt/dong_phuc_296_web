import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong_phuc_296_web/src/data/model/product_model.dart';
import 'package:dong_phuc_296_web/src/data/model/status_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'converter/TimeStampConverter.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: 'orderId')
  int? orderId;
  @JsonKey(name: 'receiverName', defaultValue: '')
  String? receiverName;
  @JsonKey(name: 'receiverPhone', defaultValue: '')
  String? receiverPhone;
  @JsonKey(name: 'receiverAddress', defaultValue: '')
  String? receiverAddress;
  @JsonKey(name: 'dateCreated')
  @TimeStampConverter()
  DateTime? dateCreated;
  @JsonKey(name: 'isDeleted', defaultValue: false)
  bool? isDeleted;
  @JsonKey(name: 'status')
  StatusModel? status;
  @JsonKey(name: 'lstProducts')
  List<ProductModel>? lstProducts;

  OrderModel({
    this.orderId,
    this.receiverName,
    this.receiverPhone,
    this.receiverAddress,
    this.dateCreated,
    this.isDeleted,
    this.status,
    this.lstProducts,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel.fromSnapshot(snapshot)
      : orderId = snapshot.data()['orderId'],
        receiverName = snapshot.data()['receiverName'],
        receiverPhone = snapshot.data()['receiverPhone'],
        receiverAddress = snapshot.data()['receiverAddress'],
        dateCreated =
            const TimeStampConverter().fromJson(snapshot.data()['dateCreated']),
        isDeleted = snapshot.data()['isDeleted'],
        status = StatusModel(
            statusId: snapshot.data()['status'], statusName: 'Đơn hàng mới'),
        lstProducts = List<ProductModel>.from(
            snapshot.data()['lstProducts'] != null
                ? snapshot
                    .data()['lstProducts']
                    .map((x) => ProductModel.fromSnapshotForOrder(x))
                : []);

  Map<String, dynamic> toMapForSnapshot() {
    return {
      'lstProducts': lstProducts?.map((x) => x.toMapForSnapshot()).toList(),
    };
  }
}
