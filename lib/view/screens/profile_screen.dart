// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glitcheffect/glitcheffect.dart';
import 'package:tik_shok/controller/auth_controller.dart';
import 'package:tik_shok/controller/profile_controller.dart';
import 'package:tik_shok/view/screens/display_video_screen.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("@${controller.user["name"]}"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.snackbar("TikTok Clone App", "Corrent Version 1.0");
                  },
                  icon: const Icon(Icons.info_outline))
            ],
          ),
          body: controller.user.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: controller.user["profilePic"],
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.account_box_outlined),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.user["followers"],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Followers",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.user["following"],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Following",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.user["likes"],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Likes",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: 150,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.blue,
                              border:
                                  Border.all(color: Colors.white, width: 0.7)),
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  if (widget.uid ==
                                      FirebaseAuth.instance.currentUser!.uid) {
                                    authController.signOut();
                                  } else {
                                    controller.followUser();
                                  }
                                },
                                child: Text(
                                  widget.uid ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? "Sign Out"
                                      : controller.user["isFollowing"]
                                          ? "Unfollow"
                                          : "Follow",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Divider(
                          indent: 30,
                          endIndent: 30,
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: controller.user["thumbnails"].length,
                          itemBuilder: (context, index) {
                            String thumbnails =
                                controller.user["thumbnails"][index];
                            return CachedNetworkImage(
                              imageUrl: thumbnails,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.account_box_outlined),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
