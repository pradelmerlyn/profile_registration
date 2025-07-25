// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseEntity _$UserResponseEntityFromJson(Map<String, dynamic> json) =>
    UserResponseEntity(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UserResponseEntityToJson(UserResponseEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
