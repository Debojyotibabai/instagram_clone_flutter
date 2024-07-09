part of 'current_user_data_bloc.dart';

@immutable
sealed class CurrentUserDataEvent {}

class GetCurrentUserDataEvent extends CurrentUserDataEvent {}
