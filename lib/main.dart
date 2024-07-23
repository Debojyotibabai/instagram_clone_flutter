import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instagram_clone/bloc/current_user_data/current_user_data_bloc.dart';
import 'package:instagram_clone/feature/auth/data/data_source/auth_data_source.dart';
import 'package:instagram_clone/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:instagram_clone/feature/auth/domain/use_case/user_login.dart';
import 'package:instagram_clone/feature/auth/domain/use_case/user_sign_up.dart';
import 'package:instagram_clone/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:instagram_clone/router/router.dart';
import 'package:instagram_clone/core/theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            userSignup: UserSignup(
              authRepository: AuthRepositoryImpl(
                authDataSource: AuthDataSourceImpl(
                  auth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance,
                ),
              ),
            ),
            userLogin: UserLogin(
              authRepository: AuthRepositoryImpl(
                authDataSource: AuthDataSourceImpl(
                  auth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(create: (context) => CurrentUserDataBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return MaterialApp.router(
          title: 'Instagram',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
          ),
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}
