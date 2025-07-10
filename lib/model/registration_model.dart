
class RegistrationModel {
  const RegistrationModel({
    required this.firstName,
    required this.lastName,
    required this.bday,
    required this.age,
    required this.email,
    required this.bio,
  });

  final String firstName;
  final String lastName;
  final String bday;
  final int age;
  final String email;
  final String bio;

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': bday,
      'age': age,
      'email': email,
      'bio': bio,
    };
  }
  RegistrationModel copyWith({
    String? firstName,
    String? lastName,
    String? bday,
    int? age,
    String? email,
    String? bio,
  }) {
    return RegistrationModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bday: bday ?? this.bday,
      age: age ?? this.age,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }

  @override
  String toString() => toJson().toString();
}
