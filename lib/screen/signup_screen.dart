// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/screen/login_screen.dart';
import 'package:travel_app/utils/custom_message.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';
import 'package:travel_app/widget/app_text_form.dart';
import 'package:travel_app/widget/big_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BigText(text: "Signup Page"),
            SizedBox(
              height: Diamentions.height16,
            ),
            AppTextForm(
              hint: "Name",
              label: "Name",
              controller: nameController,
              prefixIcon: Icons.person,
              inputType: TextInputType.name,
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
              prefixIcon: Icons.lock_outline,
              inputType: TextInputType.text,
              obscureText: true,
            ),
            AppButton(
              onPress: () {
                
                userRegistration();
              },
              title: "Sign Up",
            ),
            AppButton(
              onPress: () {
                Get.to(() => const LoginScreen());
              },
              title: "Have Account Login",
            ),
          ],
        )
        ,
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
  
      // authController.registration(name, phone, password).then((status) {
      //   if (status.isSuccess) {
      //     Get.snackBar("Registration successful",
      //         "Registration Successful");
      //     phoneController.text = '';
      //     passwordController.text = '';
      //     nameController.text = '';
      //     Get.to(()=> const LoginScreen());
      //   } else {
      //     Message.snnackBar("Please check your email or password",
      //         title: status.message);
      //   }
      // });
    }
  }
}
