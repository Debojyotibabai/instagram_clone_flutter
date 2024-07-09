import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: "/",
        builder: (context, state) => const ResponsiveLayout(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final loggedInUser = FirebaseAuth.instance.currentUser;
      final bool loggingIn = state.matchedLocation == '/login';
      final bool signingUp = state.matchedLocation == '/signup';

      if (!loggingIn && !signingUp && loggedInUser == null) {
        return "/login";
      }

      if (loggedInUser != null && (loggingIn || signingUp)) {
        return "/";
      }

      return null;
    },
  );
}
