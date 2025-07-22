part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final UserEntity userEntity;
  final int currentStep;
  final bool isSubmissionSuccess;
  final bool isLoading;
  final String errorMsg;
  final String buttonLabel;

  const RegistrationState({
    this.userEntity = const UserEntity(
        id: 0,
        firstName: '',
        lastName: '',
        birthdate: '',
        age: 0,
        bio: '',
        email: ''),
    this.currentStep = 1,
    this.isSubmissionSuccess = false,
    this.isLoading = false,
    this.errorMsg = '',
    this.buttonLabel = 'Next',
  });

  RegistrationState copyWith({
    UserEntity? userEntity,
    int? currentStep,
    bool? isSubmissionSuccess,
    bool? isLoading,
    String? buttonLabel,
    String? errorMsg,
  }) {
    return RegistrationState(
      userEntity: userEntity ?? this.userEntity,
      currentStep: currentStep ?? this.currentStep,
      isSubmissionSuccess: isSubmissionSuccess ?? this.isSubmissionSuccess,
      isLoading: isLoading ?? this.isLoading,
      buttonLabel: buttonLabel ?? this.buttonLabel,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [
        userEntity,
        currentStep,
        isSubmissionSuccess,
        isLoading,
        buttonLabel,
        errorMsg,
      ];
}
