import 'package:json_annotation/json_annotation.dart';
import 'package:sprint1_activity/domain/model/registration/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'user_list_response_entity.g.dart';

@JsonSerializable()
class UserListResponseEntity extends Equatable {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'message')
  final String? message;

  final List<UserEntity>? users;

  const UserListResponseEntity({
    this.status,
    this.message,
    this.users,
  });

    UserListResponseEntity copyWith({
    String? status,
    String? message,
    List<UserEntity>? users,
  }) {
    return UserListResponseEntity(
      status: status ?? this.status,
      message: message ?? this.message,
      users: users ?? this.users,
    );
  }


  factory UserListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseEntityToJson(this);

  @override
  List<Object?> get props => [status, message, users];
}
