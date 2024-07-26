import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
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
}

void _initAuth() {
  serviceLocator
    ..registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(
        auth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
        storage: FirebaseStorage.instance,
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: serviceLocator()),
    )
    ..registerLazySingleton(
      () => UserSignup(authRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => UserLogin(authRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => AuthBloc(userSignup: serviceLocator(), userLogin: serviceLocator()),
    );
}
