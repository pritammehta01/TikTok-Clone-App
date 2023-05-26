import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_shok/constants.dart';
import 'package:tik_shok/view/screens/add_caption_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});
  videoPick(
    ImageSource src,
  ) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.snackbar("Video Selected", video.path);
      Get.to(
          AddCaptionScreen(videoFile: File(video.path), videoPath: video.path));
    } else {
      Get.snackbar("Error In Selecting Video", "Please Select A Video");
    }
  }

  showDialoOpt(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        alignment: Alignment.center,
        children: [
          const Center(
              child: Text(
            "Select Video",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          )),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  videoPick(
                    ImageSource.gallery,
                  );
                },
                child: const Text(
                  "Gallery",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  videoPick(
                    ImageSource.camera,
                  );
                },
                child: const Text("Camera", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: InkWell(
            onTap: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialoOpt(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: const Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
