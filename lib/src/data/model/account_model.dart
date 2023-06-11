// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'converter/TimeStampConverter.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel {
  @JsonKey(name: 'fullName')
  String? fullName;
  @JsonKey(name: 'userName')
  String? userName;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'registerCode')
  String? registerCode;

  AccountModel({
    this.fullName,
    this.userName,
    this.password,
    this.registerCode,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  AccountModel.fromSnapshot(snapshot)
      : fullName = snapshot.data()['fullName'],
        userName = snapshot.data()['userName'],
        password = snapshot.data()['password'],
        registerCode = snapshot.data()['registerCode'];

  Map<String, dynamic> toMapForSnapshot() {
    return {
      'fullName': fullName,
      'userName': userName,
      'password': password,
      'registerCode': registerCode,
    };
  }

}
