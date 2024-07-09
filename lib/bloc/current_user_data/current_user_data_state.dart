part of 'current_user_data_bloc.dart';

@immutable
sealed class CurrentUserDataState {}

final class CurrentUserDataInitial extends CurrentUserDataState {}

final class CurrentUserDataLoading extends CurrentUserDataState {}

final class CurrentUserDataSuccess extends CurrentUserDataState {
  final UserModel user;
  CurrentUserDataSuccess({required this.user});
}

final class CurrentUserDataError extends CurrentUserDataState {
  final String message;
  CurrentUserDataError({required this.message});
}
