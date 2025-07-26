// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponseEntity _$UserListResponseEntityFromJson(
        Map<String, dynamic> json) =>
    UserListResponseEntity(
      status: json['status'] as String?,
      message: json['message'] as String?,
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserListResponseEntityToJson(
        UserListResponseEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'users': instance.users,
    };
