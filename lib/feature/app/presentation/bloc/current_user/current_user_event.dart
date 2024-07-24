part of 'current_user_bloc.dart';

@immutable
sealed class CurrentUserEvent {}

final class GetCurrentUserDataEvent extends CurrentUserEvent {}
