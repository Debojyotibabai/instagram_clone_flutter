// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:instagram_clone/core/theme/colors.dart';
import 'package:instagram_clone/core/utils/regexp.dart';
import 'package:instagram_clone/feature/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:instagram_clone/core/utils/utis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        AuthLogin(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                SvgPicture.asset(
                  "assets/images/ic_instagram.svg",
                  color: primaryColor,
                  height: 60,
                ),
                const SizedBox(
                  height: 70,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: "Email",
                        controller: _emailController,
                        regExp: emailRegex,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      CustomTextFormField(
                        hintText: "Password",
                        isPassword: true,
                        controller: _passwordController,
                        regExp: passwordRegex,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: login,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.blueAccent,
                            ),
                          ),
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSuccess) {
                                showSnackbar(
                                  context,
                                  state.response["message"]!,
                                );
                                context.replace("/");
                              } else if (state is AuthError) {
                                showSnackbar(
                                    context, state.response["message"]!);
                              }
                            },
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const SizedBox(
                                  height: 23.5,
                                  width: 23.5,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                );
                              }
                              return const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push("/signup");
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
