part of 'add_post_bloc.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class AddPostLoading extends AddPostState {}

final class AddPostSuccess extends AddPostState {
  final Map<String, String> response;
  AddPostSuccess({required this.response});
}

final class AddPostError extends AddPostState {
  final Map<String, String> error;
  AddPostError({required this.error});
}
