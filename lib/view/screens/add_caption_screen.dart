// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_shok/constants.dart';
import 'package:tik_shok/controller/upload_video_controller.dart';
import 'package:tik_shok/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;
  AddCaptionScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController songNameController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  VideoUploadController videoUploadController =
      Get.put(VideoUploadController());
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextInputField(
                      controller: songNameController,
                      myIcon: Icons.music_note,
                      myLabelText: "Song Name"),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputField(
                      controller: captionController,
                      myIcon: Icons.closed_caption,
                      myLabelText: "Caption"),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: buttonColor),
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      videoUploadController.uploadVideo(songNameController.text,
                          captionController.text, widget.videoPath);
                      setState(() {
                        loading = true;
                      });
                    },
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : const Text("Upload"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
