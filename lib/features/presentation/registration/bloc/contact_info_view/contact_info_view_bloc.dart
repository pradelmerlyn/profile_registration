import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'contact_info_view_event.dart';
part 'contact_info_view_state.dart';

class ContactInfoViewBloc
    extends Bloc<ContactInfoViewEvent, ContactInfoViewState> {
  ContactInfoViewBloc() : super(ContactInfoViewInitial()) {
    on<ShowPasswordEvent>(onShowPassword);
    on<ShowConfirmPasswordEvent>(onShowConfirmPassword);
  }

  void onShowPassword(
      ShowPasswordEvent event, Emitter<ContactInfoViewState> emit) async {
    try {
      emit(state.copyWith(obscurePassword: !state.obscurePassword));
      debugPrint('🆕 onShowPassword: ${state.obscurePassword}');
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
      debugPrint('🆕 onShowConfirmPassword: ${state.obscurePassword}');
    } catch (e, stackTrace) {
      log(
        'Error in onUpdateUser: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
