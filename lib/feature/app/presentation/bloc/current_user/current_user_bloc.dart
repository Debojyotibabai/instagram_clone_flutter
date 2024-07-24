// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/model/user_model.dart';
import 'package:instagram_clone/feature/app/domain/use_case/get_current_user_data.dart';
import 'package:meta/meta.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final GetCurrentUserData _getCurrentUserData;

  CurrentUserBloc({required GetCurrentUserData getCurrentUserData})
      : _getCurrentUserData = getCurrentUserData,
        super(CurrentUserInitial()) {
    on<GetCurrentUserDataEvent>((event, emit) async {
      emit(CurrentUserLoading());

      final response = await _getCurrentUserData(NoParams());

      response.fold(
        (err) => emit(CurrentUserError(response: err)),
        (res) => emit(CurrentUserSuccess(user: res)),
      );
    });
  }
}
