import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          create: (context) => serviceLocator<CurrentUserBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AddPostBloc>(),
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
