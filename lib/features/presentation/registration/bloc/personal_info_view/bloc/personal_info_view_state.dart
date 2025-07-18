part of 'personal_info_view_bloc.dart';

class PersonalInfoViewState extends Equatable {
  final String birthday;
  final int age;
  final String birthdayError;
  final int errorId;

  const PersonalInfoViewState({
    this.birthday = '',
    this.age = 0,
    this.birthdayError = '',
    this.errorId = 0,
  });

  PersonalInfoViewState copyWith({
    String? birthday,
    int? age,
    String? birthdayError,
    int? errorId,
  }) {
    return PersonalInfoViewState(
      birthday: birthday ?? this.birthday,
      age: age ?? this.age,
      birthdayError: birthdayError ?? this.birthdayError,
      errorId: errorId ?? this.errorId,
    );
  }

  @override
  List<Object> get props => [birthday, age, birthdayError, errorId];
}
