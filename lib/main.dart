import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/feature/app/data/data_source/add_post_data_source.dart';
import 'package:instagram_clone/feature/app/data/data_source/current_user_data_source.dart';
import 'package:instagram_clone/feature/app/data/repository/add_post_repository_impl.dart';
import 'package:instagram_clone/feature/app/data/repository/current_user_repository_impl.dart';
import 'package:instagram_clone/feature/app/domain/use_case/add_post.dart';
import 'package:instagram_clone/feature/app/domain/use_case/get_current_user_data.dart';
import 'package:instagram_clone/feature/app/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:instagram_clone/feature/app/presentation/bloc/current_user/current_user_bloc.dart';
import 'package:instagram_clone/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:instagram_clone/init_dependencies.dart';
import 'package:instagram_clone/router/router.dart';
import 'package:instagram_clone/core/theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => CurrentUserBloc(
            getCurrentUserData: GetCurrentUserData(
              currentUserRepository: CurrentUserRepositoryImpl(
                currentUserDataSource:
                    CurrentUserDataSourceImpl(auth: FirebaseAuth.instance),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AddPostBloc(
            addPost: AddPost(
              addPostRepository: AddPostRepositoryImpl(
                addPostDataSource: AddPostDataSourceImpl(
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance,
                ),
              ),
            ),
          ),
        ),
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
