import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/feature/app/presentation/bloc/current_user/current_user_bloc.dart';
import 'package:instagram_clone/responsive/mobile_layout.dart';
import 'package:instagram_clone/responsive/web_layout.dart';
import 'package:instagram_clone/core/utils/global_variables.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CurrentUserBloc>(context).add(
      GetCurrentUserDataEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return const WebLayout();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
