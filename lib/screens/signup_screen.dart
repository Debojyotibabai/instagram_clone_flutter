// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/regexp.dart';
import 'package:instagram_clone/utils/utis.dart';
import 'package:instagram_clone/widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  File? selectedAvatar;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    super.dispose();

    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  void signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSigningUp = true;
      });

      final response = await AuthMethods().signup(
        avatar: selectedAvatar,
        userName: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        bio: _bioController.text,
      );

      if (!mounted) return;

      setState(() {
        isSigningUp = false;
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
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
      ),
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
                      SizedBox(
                        height: 110,
                        width: 110,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundColor: secondaryColor,
                              child: ClipOval(
                                child: (selectedAvatar != null)
                                    ? Image.file(
                                        selectedAvatar!,
                                        height: 110,
                                        width: 110,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/avatar.png",
                                        height: 110,
                                        width: 110,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: -5,
                              right: -25,
                              child: RawMaterialButton(
                                onPressed: () async {
                                  final image = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                    maxWidth: 400,
                                  );

                                  if (image == null) {
                                    return showSnackbar(
                                        context, "Image is not selected");
                                  }

                                  setState(() {
                                    selectedAvatar = File(image.path);
                                  });
                                },
                                elevation: 2.0,
                                fillColor: const Color(0xFFF5F6F9),
                                padding: const EdgeInsets.all(7),
                                shape: const CircleBorder(),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.blueAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomTextFormField(
                        hintText: "User name",
                        controller: _userNameController,
                        regExp: letterOnlyRegex,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
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
                        height: 18,
                      ),
                      CustomTextFormField(
                        hintText: "Bio",
                        controller: _bioController,
                        regExp: min10Max100Regex,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: signup,
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
                          child: isSigningUp
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
                                  "Sign up",
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
                              "Already have an account?",
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
                                context.pop();
                              },
                              child: const Text(
                                "Login",
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
