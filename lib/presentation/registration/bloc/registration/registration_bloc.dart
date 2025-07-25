import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sprint1_activity/config/api_client.dart';
import 'package:sprint1_activity/data/services/api_service.dart';
import 'package:sprint1_activity/domain/model/registration/user_entity.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final ApiService apiService = ApiService(ApiClient.dio);

  RegistrationBloc() : super(const RegistrationState()) {
    on<NextStepEvent>(onNextStep);
    on<PreviousStepEvent>(onPreviousStep);
    on<UpdateUserEvent>(onUpdateUser);
    on<SubmitFormData>(onSubmitRegistration);
    on<ResetSubmissionSuccess>(onResetSubmissionSuccess);
    on<GetError>(onGetError);
    on<ResetErrorMessage>(onResetErrorMessage);
  }

  void onNextStep(NextStepEvent event, Emitter<RegistrationState> emit) {
    final nextStep = (state.currentStep + 1);

    emit(state.copyWith(
      currentStep: nextStep,
      buttonLabel: _getButtonLabel(nextStep),
    ));
  }

  void onPreviousStep(
      PreviousStepEvent event, Emitter<RegistrationState> emit) {
    final prevStep = (state.currentStep - 1);

    emit(state.copyWith(
      currentStep: prevStep,
      buttonLabel: _getButtonLabel(prevStep),
    ));
  }

  void onUpdateUser(UpdateUserEvent event, Emitter<RegistrationState> emit) {
    final updatedUser = state.userEntity.copyWith(
      firstName: event.firstName,
      lastName: event.lastName,
      birthdate: event.birthday,
      age: event.age,
      email: event.email,
      bio: event.bio,
      password: event.password,
    );

    emit(state.copyWith(userEntity: updatedUser));
  }

  Future<void> onSubmitRegistration(
      SubmitFormData event, Emitter<RegistrationState> emit) async {
    try {
      final user = state.userEntity;
      debugPrint('💁💁 USER $user ');
      await apiService.registerUser(user);
      emit(state.copyWith(isSubmissionSuccess: true));
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      emit(state.copyWith(errorMsg: e.toString(), isLoading: false));
    }
  }

  void onResetSubmissionSuccess(
      ResetSubmissionSuccess event, Emitter<RegistrationState> emit) async {
    final isSubmissionReset = state.copyWith(isSubmissionSuccess: false, isLoading: false);
    emit(isSubmissionReset);
    // debugPrint('❌ Submission Success is ${state.isSubmissionSuccess} ');
  }

  Future<void> onGetError(
      GetError event, Emitter<RegistrationState> emit) async {
    String errorMsg = "";
    emit(state.copyWith(isLoading: true));
    try {
      await apiService.triggerError();
    } on DioException catch (e) {
      //DIO error is depreciated
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMsg = "Connection timeout";
      } else {
        errorMsg = "Something went wrong";
      }
    } catch (e) {
      errorMsg = "Unexpected error";
    }
    emit(state.copyWith(errorMsg: errorMsg, isLoading: false));
    debugPrint('🖥️ DIO ERROR $errorMsg');
  }

  void onResetErrorMessage(
      ResetErrorMessage event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(errorMsg: ""));
    // debugPrint('onResetErrorMessage $state');
  }

  String _getButtonLabel(int step) {
    switch (step) {
      case 1:
        return 'Next';
      case 2:
        return 'Review';
      case 3:
        return 'Submit';
      default:
        return 'Next';
    }
  }
}
