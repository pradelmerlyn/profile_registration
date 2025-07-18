part of 'contact_info_view_bloc.dart';

abstract class ContactInfoViewEvent extends Equatable {
  const ContactInfoViewEvent();

  @override
  List<Object> get props => [];
}

class ShowPasswordEvent extends ContactInfoViewEvent {}

class ShowConfirmPasswordEvent extends ContactInfoViewEvent {}

class ValidateEmailEvent extends ContactInfoViewEvent {
  final String value;
  final String errMsg;

  const ValidateEmailEvent({
    required this.value,
    required this.errMsg
  });
}
