// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/utis.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final ImagePicker _picker = ImagePicker();

  File? selectedAvatar;

  void pickImage(type) async {
    final image = await _picker.pickImage(
      source: type,
      maxWidth: 400,
    );

    if (image == null) {
      return showSnackbar(context, "Image is not selected");
    }

    setState(() {
      selectedAvatar = File(image.path);
    });
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
                "Open camera",
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
                "Open gallery",
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
    return Center(
      child: IconButton(
        icon: const Icon(
          Icons.upload,
          size: 30,
        ),
        onPressed: () {
          selectImage(context);
        },
      ),
    );
  }
}
