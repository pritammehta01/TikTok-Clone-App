import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tik_shok/model/video_model.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class VideoUploadController extends GetxController {
  static VideoUploadController instance = Get.find();

  var uuid = Uuid();

  //genrating thumbnail
  Future<File> _getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

//uploading thumbnail to firebaseStorage
  Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("thumbnail").child(id);
    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//main video upload
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      //VideoId-uuId
      String id = uuid.v1();
      String videoUrl = await _uploadVideoToStorage(id, videoPath);
      String thumbnail = await _uploadVideoThumbToStorage(id, videoPath);
      Video video = Video(
          username: (userDoc.data()! as Map<String, dynamic>)["name"],
          uid: uid,
          id: id,
          likes: [],
          commentsCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePic: (userDoc.data()! as Map<String, dynamic>)["profilePic"]);
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(id)
          .set(video.toJson())
          .then((value) {
        Get.back();
        Get.snackbar("Video Uploaded Successfully",
            "Thanks You For Sharing Your Content");
      });
    } catch (e) {
      log("Uploading fail $e");
      Get.snackbar("Uploading fail", e.toString());
    }
  }

//uploading video to firebaseStorage
  Future<String> _uploadVideoToStorage(String videoID, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("videos").child(videoID);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//compressing video
  Future<File> _compressVideo(String videoPath) async {
    final mediaInfo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );

    final compressedVideo = mediaInfo!.file;

    return compressedVideo!;
  }
}
