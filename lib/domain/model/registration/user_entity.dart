import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final int? id;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'birthdate')
  final String birthdate;

  @JsonKey(name: 'age')
  final int? age;

  @JsonKey(name: 'bio')
  final String bio;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.age,
    required this.bio,
    required this.email,
    required this.password,
  });

  UserEntity copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? birthdate,
    int? age,
    String? bio,
    String? email,
    String? password,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthdate: birthdate ?? this.birthdate,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, birthdate, age, bio, email, password];

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
