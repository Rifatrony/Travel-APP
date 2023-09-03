// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/auth_controller.dart';
import 'package:travel_app/screen/signup_screen.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/widget/shadow_text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            controller: authController.phoneController,
            inputType: TextInputType.phone,
          ),
          SizedBox(
            height: Diamentions.height16,
          ),
          Obx( ()=>
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Diamentions.width20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(
                          8, 5), // changes the position of the shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  obscureText: authController.isPasswordHidden.value,
                  keyboardType: TextInputType.text,
                  controller: authController.passwordController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: InkWell(
                              onTap: (){
                                authController.isPasswordHidden.value =! authController.isPasswordHidden.value;
                              },
                              child: Icon(authController.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility),
                            ),
                    contentPadding: EdgeInsets.only(
                      left: Diamentions.width16,
                      right: Diamentions.width16,
                      top: Diamentions.height10,
                      bottom: Diamentions.height10,
                    ),
                    hintText: "Password",
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => AppButton(
              loading: authController.isLoading.value,
              onPress: () {
                authController.login();
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

  // void userLogin() {
  //   String phone = phoneController.text.trim();
  //   String password = passwordController.text.trim();

  //   if (phone.isEmpty) {
  //     Message.snackBar("Type in your number", title: "Phone Number");
  //   } else if (password.isEmpty) {
  //     Message.snackBar("Type in your Password", title: "Password");
  //   } else if (password.length < 6) {
  //     Message.snackBar("Password can not be less than 6 digit",
  //         title: "Password");
  //   } else {
  //     Map data = {
  //       "phone": phone,
  //       "password": password,
  //     };
  //     authController.login(data);
  //   }
  // }
}
