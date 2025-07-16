import 'dart:developer' show log;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sprint1_activity/features/domain/entities/registration/user_entity.dart';

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
    try {
      // debugPrint('🦶 Current Step: ${state.currentStep}');
      final newState = state.copyWith(currentStep: state.currentStep + 1);
      emit(newState);
      debugPrint('🆕 New Step: ${newState.currentStep}');
    } catch (e, stackTrace) {
      log(
        'Error in onNextStep: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void onPreviousStep(
      PreviousStepEvent event, Emitter<RegistrationState> emit) async {
    try {
      //debugPrint('➡️ onPreviousStep ');
      // debugPrint('🦶 Current Step: ${state.currentStep}');
      final prevState = state.copyWith(currentStep: state.currentStep - 1);
      emit(prevState);
      debugPrint('🆕 New Step: ${prevState.currentStep}');
    } catch (e, stackTrace) {
      log(
        'Error in onPreviousStep: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void onUpdateUser(
      UpdateUserEvent event, Emitter<RegistrationState> emit) async {
    try {
      emit(state.copyWith(userEntity: event.user));
      
      debugPrint('➡️ onUpdateUser ');
      debugPrint('📄 Updated Registration: ${state.userEntity.toJson()}');
    } catch (e, stackTrace) {
      log(
        'Error in onUpdateUser: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void onSubmitRegistration(
      SubmitFormData event, Emitter<RegistrationState> emit) async {
    try {
      emit(state.copyWith(isSubmissionSuccess: true));
    } catch (e, stackTrace) {
      log(
        'Error in onSubmitRegistration: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void onResetSubmissionSuccess(
      ResetSubmissionSuccess event, Emitter<RegistrationState> emit) async {
    try {
      emit(state.copyWith(isSubmissionSuccess: false));
       debugPrint('❌ ${state.isSubmissionSuccess} ');
    } catch (e, stackTrace) {
      log(
        'Error in onResetSubmissionSuccess: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
