// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/feature/app/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:instagram_clone/feature/app/presentation/bloc/current_user/current_user_bloc.dart';
import 'package:instagram_clone/core/theme/colors.dart';
import 'package:instagram_clone/core/utils/utis.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController captionController = TextEditingController();

  File? selectedPostImage;

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  void pickImage(type) async {
    final image = await _picker.pickImage(
      source: type,
    );

    if (image == null) {
      return showSnackbar(context, "Image is not selected");
    }

    setState(() {
      selectedPostImage = File(image.path);
    });

    context.pop();
  }

  void post(String uid, String userName, String avatar) {
    BlocProvider.of<AddPostBloc>(context).add(UploadPost(
      caption: captionController.text,
      image: selectedPostImage!,
      uid: uid,
      userName: userName,
      avatar: avatar,
    ));
  }

  Future selectImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              child: const Text(
                "Open Camera",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              child: const Text(
                "Pick from Gallery",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return selectedPostImage == null
        ? Center(
            child: IconButton(
              icon: const Icon(
                Icons.upload,
                size: 30,
                color: primaryColor,
              ),
              onPressed: () {
                selectImage(context);
              },
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: BackButton(
                onPressed: () {
                  setState(() {
                    selectedPostImage = null;
                  });
                },
              ),
              title: const Text(
                "Post to",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              actions: [
                BlocBuilder<CurrentUserBloc, CurrentUserState>(
                  builder: (context, state) {
                    if (state is CurrentUserSuccess) {
                      return TextButton(
                        onPressed: () {
                          post(
                            state.user.uid,
                            state.user.userName,
                            state.user.avatar,
                          );
                        },
                        child: const Text(
                          "Post",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 19,
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
            body: BlocConsumer<AddPostBloc, AddPostState>(
              listener: (context, state) {
                if (state is AddPostSuccess) {
                  showSnackbar(context, state.response["message"]!);

                  if (state.response["status"] == "success") {
                    setState(() {
                      captionController.text = "";
                      selectedPostImage = null;
                    });
                  }
                } else if (state is AddPostError) {
                  showSnackbar(context, state.error["message"]!);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    state is AddPostLoading
                        ? const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: LinearProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: BlocBuilder<CurrentUserBloc, CurrentUserState>(
                        builder: (context, state) {
                          if (state is CurrentUserLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is CurrentUserSuccess) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: secondaryColor,
                                  backgroundImage: state.user.avatar != ""
                                      ? NetworkImage(state.user.avatar)
                                      : const AssetImage(
                                              "assets/images/avatar.png")
                                          as ImageProvider<Object>?,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextField(
                                    cursorColor: Colors.blueAccent,
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 17.5,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: "Write a caption...",
                                      hintStyle: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 17.5,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) =>
                                        captionController.text = value,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Image.file(
                                  selectedPostImage!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
