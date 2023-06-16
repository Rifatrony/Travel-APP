// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/auth_controller.dart';
import 'package:travel_app/screen/signup_screen.dart';
import 'package:travel_app/utils/custom_message.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';
import 'package:travel_app/widget/app_text_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/widget/shadow_text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
          ShadowTextForm(
            hint: "Phone",
            controller: phoneController,
            inputType: TextInputType.phone,
          ),
          SizedBox(
            height: Diamentions.height16,
          ),
          ShadowTextForm(
            hint: "Password",
            controller: passwordController,
            inputType: TextInputType.text,
            isVisible: true,
          ),
          Obx(
            () => AppButton(
              loading: authController.isLoaded.value,
              onPress: () {
                userLogin();
              },
              title: "Login",
              height: 45,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Get.to(() => const SignupScreen());
            },
            child: RichText(
              text: const TextSpan(
                text: 'No Account Yet? ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void userLogin() {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (phone.isEmpty) {
      Message.snackBar("Type in your number", title: "Phone Number");
    } else if (password.isEmpty) {
      Message.snackBar("Type in your Password", title: "Password");
    } else if (password.length < 6) {
      Message.snackBar("Password can not be less than 6 digit",
          title: "Password");
    } else {
      Map data = {
        "phone": phone,
        "password": password,
      };
      authController.login(data);
    }
  }
}
