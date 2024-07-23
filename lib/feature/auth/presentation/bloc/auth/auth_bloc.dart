// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/feature/auth/domain/use_case/user_login.dart';
import 'package:instagram_clone/feature/auth/domain/use_case/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;

  AuthBloc({required UserSignup userSignup, required UserLogin userLogin})
      : _userSignup = userSignup,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignup>(
      (event, emit) async {
        emit(AuthLoading());

        final response = await _userSignup(
          UserSignupParams(
            avatar: event.avatar,
            email: event.email,
            password: event.password,
            userName: event.userName,
            bio: event.bio,
          ),
        );

        response.fold(
          (err) => emit(AuthError(err)),
          (res) => emit(AuthSuccess(res)),
        );
      },
    );
    on<AuthLogin>(
      (event, emit) async {
        emit(AuthLoading());

        final response = await _userLogin(
          UserLoginParams(
            email: event.email,
            password: event.password,
          ),
        );

        response.fold(
          (err) => emit(AuthError(err)),
          (res) => emit(AuthSuccess(res)),
        );
      },
    );
  }
}
