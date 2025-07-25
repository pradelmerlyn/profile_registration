part of 'user_list_bloc.dart';

class UserListState extends Equatable {
  const UserListState({
    this.users = const [],
    this.isLoading = false,
  });

  final List<UserEntity> users;
  final bool isLoading;

  UserListState copyWith({
    bool? isLoading,
    List<UserEntity>? users,
  }) {
    return UserListState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
    );
  }

  @override
  List<Object> get props => [isLoading, users];
}

class UserListInitial extends UserListState {}
