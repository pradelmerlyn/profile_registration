part of 'contact_info_view_bloc.dart';

class ContactInfoViewState extends Equatable {
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  const ContactInfoViewState(
      {this.obscurePassword = true, this.obscureConfirmPassword = true});

  ContactInfoViewState copyWith(
    {
      bool? obscurePassword, 
      bool? obscureConfirmPassword
    }) {
    return ContactInfoViewState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword);
  }

  @override
  List<Object?> get props => [ obscurePassword, obscureConfirmPassword ];
}

class ContactInfoViewInitial extends ContactInfoViewState {}
