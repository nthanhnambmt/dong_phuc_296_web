// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      fullName: json['fullName'] as String?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      registerCode: json['registerCode'] as String?,
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'userName': instance.userName,
      'password': instance.password,
      'registerCode': instance.registerCode,
    };
