import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/feature/app/data/data_source/add_post_data_source.dart';
import 'package:instagram_clone/feature/app/data/data_source/current_user_data_source.dart';
import 'package:instagram_clone/feature/app/data/repository/add_post_repository_impl.dart';
import 'package:instagram_clone/feature/app/data/repository/current_user_repository_impl.dart';
import 'package:instagram_clone/feature/app/domain/repository/add_post_repository.dart';
import 'package:instagram_clone/feature/app/domain/repository/current_user_repository.dart';
import 'package:instagram_clone/feature/app/domain/use_case/add_post.dart';
import 'package:instagram_clone/feature/app/domain/use_case/get_current_user_data.dart';
import 'package:instagram_clone/feature/app/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:instagram_clone/feature/app/presentation/bloc/current_user/current_user_bloc.dart';
import 'package:instagram_clone/feature/auth/data/data_source/auth_data_source.dart';
import 'package:instagram_clone/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:instagram_clone/feature/auth/domain/repository/auth_repository.dart';
import 'package:instagram_clone/feature/auth/domain/use_case/user_login.dart';
import 'package:instagram_clone/feature/auth/domain/use_case/user_sign_up.dart';
import 'package:instagram_clone/feature/auth/presentation/bloc/auth/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: ".env");

  if (kIsWeb || defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY']!,
        appId: dotenv.env['FIREBASE_APP_ID']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  _initAuth();
  _getCurrentUserData();
  _addPost();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthDataSource>(
      () => AuthDataSourceImpl(
        auth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
        storage: FirebaseStorage.instance,
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: serviceLocator()),
    )
    ..registerFactory(
      () => UserSignup(authRepository: serviceLocator()),
    )
    ..registerFactory(
      () => UserLogin(authRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => AuthBloc(userSignup: serviceLocator(), userLogin: serviceLocator()),
    );
}

void _getCurrentUserData() {
  serviceLocator
    ..registerFactory<CurrentUserDataSource>(
      () => CurrentUserDataSourceImpl(auth: FirebaseAuth.instance),
    )
    ..registerFactory<CurrentUserRepository>(
      () => CurrentUserRepositoryImpl(currentUserDataSource: serviceLocator()),
    )
    ..registerFactory(
      () => GetCurrentUserData(currentUserRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => CurrentUserBloc(getCurrentUserData: serviceLocator()),
    );
}

void _addPost() {
  serviceLocator
    ..registerFactory<AddPostDataSource>(
      () => AddPostDataSourceImpl(
          storage: FirebaseStorage.instance,
          firestore: FirebaseFirestore.instance),
    )
    ..registerFactory<AddPostRepository>(
      () => AddPostRepositoryImpl(addPostDataSource: serviceLocator()),
    )
    ..registerFactory(
      () => AddPost(addPostRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => AddPostBloc(addPost: serviceLocator()),
    );
}
