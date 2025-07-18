part of 'personal_info_view_bloc.dart';

abstract class PersonalInfoViewEvent extends Equatable {
  const PersonalInfoViewEvent();

  @override
  List<Object> get props => [];
}

class ValidateBirthdayEvent extends PersonalInfoViewEvent {
  final DateTime pickedDate;

  const ValidateBirthdayEvent(this.pickedDate);

  @override
  List<Object> get props => [pickedDate];
}
