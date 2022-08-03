// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel {
  @JsonKey(name: 'statusId', defaultValue: 1)
  int? statusId;
  @JsonKey(name: 'statusName')
  String? statusName;

  StatusModel({
    this.statusId,
    this.statusName,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) =>
      _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);


  StatusModel.fromSnapshot(snapshot)
      : statusId = snapshot.data()['statusId'],
        statusName = snapshot.data()['statusName'];
}
