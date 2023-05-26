import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:tik_shok/controller/video_controller.dart';
import 'package:tik_shok/view/screens/comment_screen.dart';
import 'package:tik_shok/view/screens/profile_screen.dart';
import 'package:tik_shok/view/widgets/album_rotator.dart';
import 'package:tik_shok/view/widgets/profile_button.dart';
import 'package:tik_shok/view/widgets/tiktok_video_player.dart';

class DisplayVideoScreen extends StatelessWidget {
  DisplayVideoScreen({Key? key}) : super(key: key);
  final VideoController videoController = Get.put(VideoController());

  Future<void> share(String vidId) async {
    await FlutterShare.share(
      title: 'Download My TikTok Clone App',
      text: 'Watch Intresting Shorts Videos On TikTok Clone',
    );
    videoController.shareVideo(vidId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return InkWell(
              onDoubleTap: () {
                videoController.likedVideo(data.id);
              },
              child: Stack(
                children: [
                  TikTokVideoPlayer(
                    videoUrl: data.videoUrl,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.account_circle,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text("@${data.username}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 25)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.closed_caption,
                              size: 25,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              data.caption,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.music_note,
                              size: 25,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(data.songName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 18,
                      left: 100,
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Following   |",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "For You",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                        ],
                      )),
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.2,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5,
                          right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(ProfileScreen(uid: data.uid));
                            },
                            child: ProfileButton(
                              profilePicUrl: data.profilePic,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              videoController.likedVideo(data.id);
                            },
                            child: Column(
                              children: [
                                Icon(Icons.favorite,
                                    size: 30,
                                    color: data.likes.contains(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        ? Colors.pink
                                        : Colors.white),
                                Text(
                                  data.likes.length.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              share(data.id);
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.reply,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  data.shareCount.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(CommentScreen(id: data.id));
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.chat_bubble,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  data.commentsCount.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                AlbumRotator(profilePicUrl: data.profilePic)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
