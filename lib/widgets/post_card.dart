import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: secondaryColor,
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Debojyoti Ghosh Debojyoti Ghosh Debojyoti Ghosh Debojyoti Ghosh",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                size: 27,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Image.asset(
          "assets/images/post_bg.jpg",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      ],
    );
  }
}
