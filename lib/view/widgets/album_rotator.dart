// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AlbumRotator extends StatefulWidget {
  String profilePicUrl;
  AlbumRotator({
    Key? key,
    required this.profilePicUrl,
  }) : super(key: key);

  @override
  State<AlbumRotator> createState() => _AlbumRotatorState();
}

class _AlbumRotatorState extends State<AlbumRotator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    controller.forward();
    controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(children: [
          Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Colors.grey,
                    Colors.white,
                  ]),
                  borderRadius: BorderRadius.circular(35)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image(
                  image: NetworkImage(
                    widget.profilePicUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ))
        ]),
      ),
    );
  }
}
