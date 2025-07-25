part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends RegistrationEvent {
  final String firstName;
  final String lastName;
  final String birthday;
  final int age;
  final String email;
  final String bio;
  final String password;

  const UpdateUserEvent({
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.age,
    required this.email,
    required this.bio,
    required this.password,
  });
  @override
  List<Object> get props => [firstName, lastName, birthday, age, email, bio, password];
}

class NextStepEvent extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class PreviousStepEvent extends RegistrationEvent {
  @override
  List<Object> get props => [];
}


class ResetSubmissionSuccess extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class SubmitFormData extends RegistrationEvent {
  final UserEntity user;

  const SubmitFormData(this.user);

  @override
  List<Object> get props => [];
}

class GetError extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class ResetErrorMessage extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

