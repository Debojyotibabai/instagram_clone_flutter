import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/current_user_data/current_user_data_bloc.dart';
import 'package:instagram_clone/responsive/mobile_layout.dart';
import 'package:instagram_clone/responsive/web_layout.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CurrentUserDataBloc>(context).add(
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
