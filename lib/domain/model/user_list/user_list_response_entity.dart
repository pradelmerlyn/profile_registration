import 'package:json_annotation/json_annotation.dart';
import 'package:sprint1_activity/domain/model/registration/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'user_list_response_entity.g.dart';

@JsonSerializable()
class UserListResponseEntity extends Equatable {
  final List<UserEntity> users;

  const UserListResponseEntity({required this.users});

  factory UserListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseEntityToJson(this);

  @override
  List<Object?> get props => [users];
}
