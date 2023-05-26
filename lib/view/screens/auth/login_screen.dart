import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tik_shok/constants.dart';
import 'package:tik_shok/controller/auth_controller.dart';
import 'package:tik_shok/view/screens/auth/signup_screen.dart';
import 'package:tik_shok/view/screens/home_screen.dart';
import 'package:tik_shok/view/widgets/text_input.dart';
import 'package:glitcheffect/glitcheffect.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailCntroller = TextEditingController();
  final TextEditingController _passwordCntroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GlitchEffect(
              child: Text(
                "TikTok",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                  controller: _passwordCntroller,
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
                      hintText: "Password"),
                  validator: (value) {
                    if (value!.length < 6 || value.isEmpty) {
                      return "Password must be 6 Digit";
                    } else {
                      return null;
                    }
                  },
                )),
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
                        AuthController.instance.login(
                            email: _emailCntroller.text,
                            password: _passwordCntroller.text);
                        Get.offAll(() => HomeScreen());
                      }
                    },
                    child: const Text("Login"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Dont have an account ?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.offAll(() => SignUpScreen());
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(letterSpacing: 1, fontSize: 16),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
