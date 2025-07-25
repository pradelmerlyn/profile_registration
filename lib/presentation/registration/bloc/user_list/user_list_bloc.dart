import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sprint1_activity/config/api_client.dart';
import 'package:sprint1_activity/data/services/api_service.dart';
import 'package:sprint1_activity/domain/model/registration/user_entity.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final ApiService apiService = ApiService(ApiClient.dio);
  UserListBloc() : super(UserListInitial()) {
    on<FetchUsers>(onFetchUsers);
  }

  Future<void> onFetchUsers(
      FetchUsers event, Emitter<UserListState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await apiService.getUsers();
      debugPrint("🙋 users: $response");
      emit(state.copyWith(isLoading: false, users: response.users));
    } catch (e, stackTrace) {
      log('FetchUsers error: $e', stackTrace: stackTrace);
      emit(state.copyWith(isLoading: false));
    }
  }
}
