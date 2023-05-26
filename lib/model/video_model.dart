import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String id;
  String uid;
  List likes;
  int commentsCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePic;
  Video({
    required this.username,
    required this.id,
    required this.uid,
    required this.likes,
    required this.commentsCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePic,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
        "uid": uid,
        "likes": likes,
        "commentsCount": commentsCount,
        "shareCount": shareCount,
        "songName": songName,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
        "profilePic": profilePic,
      };
  static Video fromSnap(DocumentSnapshot snap) {
    var sst = snap.data() as Map<String, dynamic>;
    return Video(
        username: sst["username"],
        id: sst["id"],
        uid: sst["uid"],
        likes: sst["likes"],
        commentsCount: sst["commentsCount"],
        shareCount: sst["shareCount"],
        songName: sst["songName"],
        caption: sst["caption"],
        videoUrl: sst["videoUrl"],
        thumbnail: sst["thumbnail"],
        profilePic: sst["profilePic"]);
  }
}
