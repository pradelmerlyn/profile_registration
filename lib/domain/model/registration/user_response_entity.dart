import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response_entity.g.dart';

@JsonSerializable()
class UserResponseEntity extends Equatable {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'message')
  final String message;

  const UserResponseEntity({
    required this.status,
    required this.message,
  });

  UserResponseEntity copyWith({
    String? status,
    String? message,
  }) {
    return UserResponseEntity(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [status, message,];

  factory UserResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseEntityToJson(this);
}
