import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sprint1_activity/domain/entities/registration/user_entity.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const RegistrationInitial()) {
    on<NextStepEvent>(onNextStep);
    on<PreviousStepEvent>(onPreviousStep);
    on<UpdateUserEvent>(onUpdateUser);
    on<SubmitFormData>(onSubmitRegistration);
    on<ResetSubmissionSuccess>(onResetSubmissionSuccess);
  }

  void onNextStep(NextStepEvent event, Emitter<RegistrationState> emit) async {
    final nextStep = state.currentStep + 1;
    emit(state.copyWith(currentStep: nextStep));
    //debugPrint('🆕 New Step: $nextStep');

    //add(UpdateUserEvent(state.userEntity));
  }

  void onPreviousStep(
      PreviousStepEvent event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(currentStep: state.currentStep - 1));
   // debugPrint('⬅️ Back to Step: ${state.currentStep}');
    add(UpdateUserEvent(state.userEntity));
  }

  void onUpdateUser(
      UpdateUserEvent event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(userEntity: event.user));
   // debugPrint('UPDATE USER 💁 ${state.userEntity.toJson()}');
  }

  void onSubmitRegistration(
      SubmitFormData event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(isSubmissionSuccess: true));
  }

  void onResetSubmissionSuccess(
      ResetSubmissionSuccess event, Emitter<RegistrationState> emit) async {
    final isSubmissionReset = state.copyWith(isSubmissionSuccess: false);
    emit(isSubmissionReset);
    debugPrint('❌ Submission Success is ${state.isSubmissionSuccess} ');
  }

  

}
