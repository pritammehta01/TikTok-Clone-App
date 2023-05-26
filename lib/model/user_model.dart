import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String name;
  String email;
  String prifilePic;
  String uid;
  MyUser({
    required this.name,
    required this.email,
    required this.prifilePic,
    required this.uid,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profilePic": prifilePic,
        "uid": uid,
      };
  static MyUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MyUser(
        name: snapshot["name"],
        email: snapshot["email"],
        prifilePic: snapshot["profilePic"],
        uid: snapshot["uid"]);
  }
}
