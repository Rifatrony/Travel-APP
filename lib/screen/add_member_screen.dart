// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/member_controller.dart';
import 'package:travel_app/utils/app_constants.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';
import 'package:travel_app/widget/app_text_form.dart';

class AddMemberScreen extends StatefulWidget {
  String id;
  String? name;
  String? phone;
  String? amount;
  AddMemberScreen({
    super.key,
    required this.id,
    this.name,
    this.phone,
    this.amount,
  });

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final memberController = Get.put(MemberController());
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();

  

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      isEdit = true;
      final amount = widget.amount!;
      final name = widget.name!;
      final phone = widget.phone!;

      nameController.text = name.toString();
      phoneController.text = phone.toString();
      amountController.text = amount.toString();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Update Member" : "Add Member"),
        backgroundColor: Colors.redAccent.shade400,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Diamentions.height20,
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

          isEdit? Text("Show here previous money"): Container(),

          AppTextForm(
            hint: "Amount",
            label: "Amount",
            controller: amountController,
            prefixIcon: Icons.request_quote,
            inputType: TextInputType.number,
          ),
          Obx(() {
            return AppButton(
              loading: memberController.addLoading.value,
              onPress: () {
                isEdit ? updateMember() : saveMember();
              },
              title: isEdit ? "Update Member" : "Add Member",
              radius: Diamentions.radius16,
            );
          }),
        ],
      ),
    );
  }

  void saveMember() {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String amount = amountController.text.trim();

    if (name.isEmpty) {
      Get.snackbar(
        "Amount Required",
        "Write amount here",
      );
    } else if (phone.isEmpty) {
      Get.snackbar(
        "Amount Required",
        "Write amount here",
      );
    } else if (amount.isEmpty) {
      Get.snackbar(
        "Amount Required",
        "Write amount here",
      );
    } else {
      Map data = {
        "name": name,
        "phone": phone,
        "given_amount": amount,
      };
      memberController.addMember(
        data,
        "${AppConstants.addMemberUrl}/${widget.id}",
      );
    }
  }
  
  updateMember() {
    
  }
}
