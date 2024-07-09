// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/model/user_model.dart';

part 'current_user_data_event.dart';
part 'current_user_data_state.dart';

class CurrentUserDataBloc
    extends Bloc<CurrentUserDataEvent, CurrentUserDataState> {
  CurrentUserDataBloc() : super(CurrentUserDataInitial()) {
    on<GetCurrentUserDataEvent>(
      (event, emit) async {
        emit(CurrentUserDataLoading());

        try {
          CollectionReference users =
              FirebaseFirestore.instance.collection('users');

          final DocumentSnapshot snapshot =
              await users.doc(FirebaseAuth.instance.currentUser!.uid).get();

          emit(
            CurrentUserDataSuccess(
              user: UserModel.fromSnap(snapshot),
            ),
          );
        } catch (error) {
          print(error);
          emit(CurrentUserDataError(message: error.toString()));
        }
      },
    );
  }
}
