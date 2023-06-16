// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/controller/auth_controller.dart';
import 'package:travel_app/screen/login_screen.dart';
import 'package:travel_app/utils/custom_message.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';
import 'package:travel_app/widget/app_text_form.dart';
import 'package:travel_app/widget/big_text.dart';
import 'package:travel_app/widget/shadow_text_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final authController = Get.put(AuthController());

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Travel Management\nSystem",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  fontSize: Diamentions.font20, letterSpacing: 1),
            ),
          ),
          SizedBox(
            height: Diamentions.height20,
          ),
          ShadowTextForm(hint: "Name", controller: nameController, inputType: TextInputType.name,),
          SizedBox(
            height: Diamentions.height16,
          ),
          ShadowTextForm(hint: "Phone", controller: phoneController, inputType: TextInputType.phone,),
          SizedBox(
            height: Diamentions.height16,
          ),
          ShadowTextForm(hint: "Password", controller: passwordController, inputType: TextInputType.text, isVisible: true,),
         
          AppButton(
            onPress: () {
              userRegistration();
            },
            title: "Sign Up",
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Get.to(() => const LoginScreen());
            },
            child: RichText(
              text: const TextSpan(
                text: 'Already Have Account? ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void userRegistration() {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty) {
      Message.snackBar(
        "Type in your name",
        title: "Name",
      );
    } else if (phone.isEmpty) {
      Message.snackBar(
        "Type in your pnone",
        title: "Phone Number",
      );
    } else if (password.length < 6) {
      Message.snackBar(
        "Password can not be less than 6 digit",
        title: "Password",
      );
    } else if (password.isEmpty) {
      Message.snackBar(
        "Type in your password",
        title: "Password",
      );
    } else {
      Map data = {
        "name": name,
        "phone": phone,
        "password": password,
      };
      authController.registration(data);
    }
  }
}
