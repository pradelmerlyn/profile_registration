part of 'contact_info_view_bloc.dart';

class ContactInfoViewState extends Equatable {
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String emailValue;
  final String emailError;

  const ContactInfoViewState(
    {
      this.obscurePassword = true, 
      this.obscureConfirmPassword = true,
      this.emailValue = '',
      this.emailError = '',
    });

  ContactInfoViewState copyWith(
      {
        bool? obscurePassword, 
        bool? obscureConfirmPassword,
        String? emailValue,
        String? emailError,
      }) {
    return ContactInfoViewState(
        obscurePassword: obscurePassword ?? this.obscurePassword,
        obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
        emailValue: emailValue ?? this.emailValue,
        emailError: emailError ?? this.emailError
      );
  }

  @override
  List<Object?> get props => [obscurePassword, obscureConfirmPassword, emailValue, emailError];
}

class ContactInfoViewInitial extends ContactInfoViewState {
  const ContactInfoViewInitial() : super();
}
