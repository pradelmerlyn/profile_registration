import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'personal_info_view_event.dart';
part 'personal_info_view_state.dart';

class PersonalInfoViewBloc
    extends Bloc<PersonalInfoViewEvent, PersonalInfoViewState> {
  PersonalInfoViewBloc() : super(const PersonalInfoViewState()) {
    on<ValidateBirthdayEvent>(onValidateBirthday);
  }

  void onValidateBirthday(
      ValidateBirthdayEvent event, Emitter<PersonalInfoViewState> emit) {
    final today = DateTime.now();
    int age = today.year - event.pickedDate.year;

    if (today.month < event.pickedDate.month ||
        (today.month == event.pickedDate.month &&
            today.day < event.pickedDate.day)) {
      age--;
    }

    if (age > 99) {
      emit(state.copyWith(
        birthday: '',
        age: 0,
        birthdayError: 'Age cannot be greater than 99.',
        errorId: DateTime.now().millisecondsSinceEpoch,
      ));
    } else {
      debugPrint('🎂 age is $age');
      emit(state.copyWith(
        birthday:
            '${event.pickedDate.month}/${event.pickedDate.day}/${event.pickedDate.year}',
        age: age,
        birthdayError: '',
        errorId: 0,
      ));
    }
  }

  String? validateTitleCase({
    String? value,
    String? errMsg,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    final words = value.trim().split(RegExp(r'\s+'));
    for (final word in words) {
      if (word.isEmpty) continue;

      final firstLetter = word[0];
      final rest = word.substring(1);

      if (firstLetter != firstLetter.toUpperCase() ||
          rest != rest.toLowerCase()) {
        return errMsg;
      }
    }

    return null; // Valid
  }
}
