// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileButton extends StatelessWidget {
  String profilePicUrl;
  ProfileButton({
    Key? key,
    required this.profilePicUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
                padding: const EdgeInsets.all(1),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image(
                    image: NetworkImage(
                      profilePicUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
