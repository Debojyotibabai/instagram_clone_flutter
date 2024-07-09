// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/bloc/current_user_data/current_user_data_bloc.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utis.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final ImagePicker _picker = ImagePicker();

  File? selectedPostImage;

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
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      BlocBuilder<CurrentUserDataBloc, CurrentUserDataState>(
                        builder: (context, state) {
                          if (state is CurrentUserDataSuccess) {
                            return CircleAvatar(
                              radius: 22,
                              backgroundColor: secondaryColor,
                              backgroundImage: state.user.avatar != ""
                                  ? NetworkImage(state.user.avatar)
                                  : const AssetImage("assets/images/avatar.png")
                                      as ImageProvider<Object>?,
                            );
                          }

                          return Container();
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                        child: TextField(
                          cursorColor: Colors.blueAccent,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 17.5,
                          ),
                          decoration: InputDecoration(
                            hintText: "Write a caption...",
                            hintStyle: TextStyle(
                              color: secondaryColor,
                              fontSize: 17.5,
                            ),
                            border: InputBorder.none,
                          ),
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
                  ),
                ],
              ),
            ),
          );
  }
}
