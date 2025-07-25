part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserListEvent {

  const FetchUsers();

  @override
  List<Object> get props => [];
}
