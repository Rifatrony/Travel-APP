import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/widget/big_text.dart';

class Message {
  static void snackBar(String message,
      {bool isError = true, String title = "error"}) {
    Get.snackbar(
      title,
      message,
      titleText: BigText(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
    );
  }
}
