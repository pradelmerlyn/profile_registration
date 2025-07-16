part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final UserEntity userEntity;
  final int currentStep;
  final bool isSubmissionSuccess;
  final String error;

  const RegistrationState(
    {
      required this.userEntity,
      this.currentStep = 0,
      this.isSubmissionSuccess = false,
      this.error = ''
    });

  RegistrationState copyWith({
    UserEntity? userEntity,
    int? currentStep,
    bool? isSubmissionSuccess,
    String? error,
  }) {
    return RegistrationState(
      userEntity: userEntity ?? this.userEntity,
      currentStep: currentStep ?? this.currentStep,
      isSubmissionSuccess: isSubmissionSuccess ?? this.isSubmissionSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    userEntity,
    currentStep,
    isSubmissionSuccess,
    error,
  ];
}

class RegistrationInitial extends RegistrationState {
   //set the currentStep to 1 for pageHeader UI and set the default initial value of UserEntity
  const RegistrationInitial()
   : super(
    currentStep: 1,
    userEntity: const UserEntity(
      firstName: '', 
      lastName: '', 
      birthdate: '', 
      age: 0, 
      bio: '', 
      email: ''
    ),
  
  );
}
