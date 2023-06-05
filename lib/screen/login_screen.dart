// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/auth_controller.dart';
import 'package:travel_app/screen/signup_screen.dart';
import 'package:travel_app/utils/custom_message.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';
import 'package:travel_app/widget/app_text_form.dart';

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
              "Login to\nContinue",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Diamentions.font20, letterSpacing: 1),
            ),
          ),
          SizedBox(
            height: Diamentions.height20,
          ),
          AppTextForm(
            hint: "Phone",
            label: "Phone",
            controller: phoneController,
            prefixIcon: Icons.phone,
            inputType: TextInputType.phone,
          ),
          AppTextForm(
            hint: "Password",
            label: "Password",
            controller: passwordController,
            prefixIcon: Icons.lock,
            inputType: TextInputType.text,
            obscureText: true,
          ),
          Obx(
            () => AppButton(
              loading: authController.isLoaded.value,
              onPress: () {
                userLogin();
              },
              title: "Login",
            ),
          ),
          AppButton(
            onPress: () {
              Get.to(() => const SignupScreen());
            },
            title: "No Account sign up",
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
