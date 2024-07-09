// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/regexp.dart';
import 'package:instagram_clone/utils/utis.dart';
import 'package:instagram_clone/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoginUp = false;

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoginUp = true;
      });

      final response = await AuthMethods().login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      setState(() {
        isLoginUp = false;
      });

      showSnackbar(context, response["message"]!);

      if (response["status"] == "success") {
        context.replace("/");
      }
    }
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
                          child: isLoginUp
                              ? const SizedBox(
                                  height: 23.5,
                                  width: 23.5,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
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
