import 'package:flutter/material.dart';
import 'package:travel_app/utils/diamention.dart';

class AppTextForm extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final IconData prefixIcon;
  final TextInputType inputType;

  const AppTextForm({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    this.obscureText = false,
    required this.prefixIcon,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Diamentions.width16,
        right: Diamentions.width16,
        top: Diamentions.height5,
        bottom: Diamentions.height10,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(prefixIcon),
          // suffixIcon: IconButton(
          //   onPressed: () {
              
          //     obscureText == true? Icon(Icons.visibility): Icon(Icons.visibility_off);
          //   },
          //   icon: obscureText
          //       ? Icon(Icons.remove_red_eye)
          //       : Icon(Icons.visibility_off),
          // ),
          contentPadding: EdgeInsets.only(
            left: Diamentions.width20,
            right: Diamentions.width20,
            top: Diamentions.height5,
            bottom: Diamentions.height5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Diamentions.radius10,
            ),
          ),
        ),
      ),
    );
  }
}
