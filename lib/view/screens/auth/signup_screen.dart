import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_shok/constants.dart';
import 'package:tik_shok/controller/auth_controller.dart';
import 'package:tik_shok/view/screens/auth/login_screen.dart';
import 'package:tik_shok/view/screens/home_screen.dart';
import 'package:tik_shok/view/widgets/text_input.dart';
import 'package:glitcheffect/glitcheffect.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailCntroller = TextEditingController();

  final TextEditingController _setPasswordCntroller = TextEditingController();

  final TextEditingController _conformPasswordCntroller =
      TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GlitchEffect(
                  child: Text(
                    "Welcome To TikTok",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    AuthController.instance.pickImage();
                  },
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 70,
                        child: Icon(
                          Icons.account_circle,
                          //color: Colors.grey,
                          size: 150,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(40)),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.black,
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _emailCntroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: borderColor),
                          ),
                          // prefixIcon:,
                          hintText: "Email"),
                      validator: (value) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!)
                            ? null
                            : "please enter a valid email";
                      },
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _setPasswordCntroller,
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.lock_open),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: borderColor),
                          ),
                          hintText: "Set Password"),
                      validator: (value) {
                        if (value!.length < 6 || value.isEmpty) {
                          return "Password must be 6 Digit";
                        } else {
                          return null;
                        }
                      },
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    toHide: true,
                    controller: _conformPasswordCntroller,
                    myLabelText: "Conform Password",
                    myIcon: Icons.lock_open,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _userNameController,
                    myLabelText: "User Name",
                    myIcon: Icons.person,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 45,
                  width: 300,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthController.instance.signUp(
                              _userNameController.text.toString(),
                              _emailCntroller.text.toString(),
                              _setPasswordCntroller.text.toString(),
                              AuthController.instance.proImg);
                          Get.offAll(() => HomeScreen());
                        }
                      },
                      child: const Text("Sign Up")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.offAll(() => LoginScreen());
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(letterSpacing: 1, fontSize: 16),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
