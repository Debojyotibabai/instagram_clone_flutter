part of 'add_post_bloc.dart';

@immutable
sealed class AddPostEvent {}

final class UploadPost extends AddPostEvent {
  final String caption;
  final File image;
  final String uid;
  final String userName;
  final String avatar;
  UploadPost({
    required this.caption,
    required this.image,
    required this.uid,
    required this.userName,
    required this.avatar,
  });
}
