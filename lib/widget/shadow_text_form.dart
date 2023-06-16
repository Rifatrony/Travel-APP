import 'package:flutter/material.dart';
import 'package:travel_app/utils/diamention.dart';

class ShadowTextForm extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool? isVisible;

  const ShadowTextForm({
    super.key,
    required this.hint,
    required this.controller,
    required this.inputType,
    this.isVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              offset: const Offset(8, 5), // changes the position of the shadow
            ),
          ],
        ),
        child: TextFormField(
          obscureText: isVisible!,
          keyboardType: inputType,
          controller: controller,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
              left: Diamentions.width16,
              right: Diamentions.width16,
              top: Diamentions.height10,
              bottom: Diamentions.height10,
            ),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
