import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'birthdate')
  final String birthdate;

  @JsonKey(name: 'age')
  final int age;

  @JsonKey(name: 'bio')
  final String bio;

  @JsonKey(name: 'email')
  final String email;

  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.age,
    required this.bio,
    required this.email,
  });

  UserEntity copyWith({
    String? firstName,
    String? lastName,
    String? birthdate,
    int? age,
    String? bio,
    String? email,
  }) {
    return UserEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthdate: birthdate ?? this.birthdate,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, birthdate, age, bio, email];

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
