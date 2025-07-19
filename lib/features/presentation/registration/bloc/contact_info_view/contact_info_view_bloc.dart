import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_info_view_event.dart';
part 'contact_info_view_state.dart';

class ContactInfoViewBloc
    extends Bloc<ContactInfoViewEvent, ContactInfoViewState> {
  ContactInfoViewBloc() : super(ContactInfoViewInitial()) {
    on<ShowPasswordEvent>(onShowPassword);
    on<ShowConfirmPasswordEvent>(onShowConfirmPassword);
    on<ValidateEmailEvent>(onValidateEmail);
  }

  void onShowPassword(
      ShowPasswordEvent event, Emitter<ContactInfoViewState> emit) async {
    try {
      emit(state.copyWith(obscurePassword: !state.obscurePassword));
      //debugPrint('🆕 onShowPassword: ${state.obscurePassword}');
    } catch (e, stackTrace) {
      log(
        'Error in onUpdateUser: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void onShowConfirmPassword(ShowConfirmPasswordEvent event,
      Emitter<ContactInfoViewState> emit) async {
    try {
      emit(state.copyWith(
          obscureConfirmPassword: !state.obscureConfirmPassword));
     // debugPrint('🆕 onShowConfirmPassword: ${state.obscurePassword}');
    } catch (e, stackTrace) {
      log(
        'Error in onUpdateUser: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void onValidateEmail(
      ValidateEmailEvent event, Emitter<ContactInfoViewState> emit) async {
    String? error;

    if (event.value.isEmpty) {
      error = 'Please enter your email';
    } else {
      final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      );
      if (!emailRegex.hasMatch(event.value.trim())) {
        error = event.errMsg;
      }
    }

    emit(state.copyWith(
      emailValue: event.value,
      emailError: error ?? '',
    ));
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, passwordCtrl) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordCtrl) {
      return 'Passwords do not match';
    }
    return null;
  }
}
