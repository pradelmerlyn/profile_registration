part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends RegistrationEvent {
  final UserEntity user;
  const UpdateUserEvent(this.user);

  @override
  List<Object> get props => [];
}


class NextStepEvent extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class PreviousStepEvent extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class SubmitFormData extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class ResetSubmissionSuccess extends RegistrationEvent {
  @override
  List<Object> get props => [];
}


