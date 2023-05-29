import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_shok/model/user_model.dart';
import 'package:tik_shok/view/screens/auth/login_screen.dart';
import 'package:tik_shok/view/screens/auth/signup_screen.dart';
import 'package:tik_shok/view/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxString imagePath = "".obs;
  //selected image
  File? proImg;
  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final img = File(image.path);
      imagePath.value = image.path.toString();
      proImg = img;
    } else {
      return null;
    }
  }

// User State Persistence
  late Rx<User?> _user;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => SignUpScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

// restering user in firebase
  void signUp(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadProfilePic(image);
        //creating instence of MyUser
        MyUser user = MyUser(
            name: username,
            email: email,
            prifilePic: downloadUrl,
            uid: credential.user!.uid);

        //storing data in firebasefirestore
        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Error While Creating Account", "Please Fill All Fields");
      }
    } catch (e) {
      Get.snackbar("Error Occured", e.toString());
    }
  }

//storing image in FirebaseStorage
  Future<String> _uploadProfilePic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

// for user login
  void login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Get.snackbar("Login", "Successfully");
      } else {
        Get.snackbar("Login Error", "Please Fill All Fields");
      }
    } catch (e) {
      Get.snackbar("Error Occured", e.toString());
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
  }
}
