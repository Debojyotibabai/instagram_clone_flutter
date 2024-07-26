// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/feature/app/domain/use_case/add_post.dart';
import 'package:meta/meta.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPost _addPost;

  AddPostBloc({required AddPost addPost})
      : _addPost = addPost,
        super(AddPostInitial()) {
    on<UploadPost>((event, emit) async {
      emit(AddPostLoading());
      final response = await _addPost(AddPostParams(
        caption: event.caption,
        image: event.image,
        uid: event.uid,
        userName: event.userName,
        avatar: event.avatar,
      ));

      response.fold(
        (err) => emit(AddPostError(error: err)),
        (res) => emit(AddPostSuccess(response: res)),
      );
    });
  }
}
