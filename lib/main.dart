import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/current_user_data/current_user_data_bloc.dart';
import 'package:instagram_clone/router/router.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb || defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBimt0pe5Vat6IsjA8QUHOaiaCKfwUNGwI",
        appId: "1:881715470598:web:035a2b22c411ac8e327e87",
        messagingSenderId: "881715470598",
        projectId: "instagram-clone-41666",
        storageBucket: "instagram-clone-41666.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    MultiBlocProvider(
      providers: [
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
