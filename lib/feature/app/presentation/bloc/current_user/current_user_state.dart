part of 'current_user_bloc.dart';

@immutable
sealed class CurrentUserState {}

final class CurrentUserInitial extends CurrentUserState {}

final class CurrentUserLoading extends CurrentUserState {}

final class CurrentUserSuccess extends CurrentUserState {
  final UserModel user;
  CurrentUserSuccess({required this.user});
}

final class CurrentUserError extends CurrentUserState {
  final Map<String, String> response;
  CurrentUserError({required this.response});
}
