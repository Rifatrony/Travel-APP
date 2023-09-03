// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/member_controller.dart';
import 'package:travel_app/utils/app_constants.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';
import 'package:travel_app/widget/big_text.dart';
import 'package:travel_app/widget/shadow_text_form.dart';

class MoneyScreen extends StatefulWidget {
  final String id;
  final String amount;
  final String type;
  const MoneyScreen(
      {super.key, required this.id, required this.amount, required this.type});

  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  final memberController = Get.put(MemberController());

  final amountController = TextEditingController();

  bool isAddMoney = false;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'add') {
      isAddMoney = true;
      final amount = widget.amount;
      final id = widget.id;

      // amountController.text = amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAddMoney ? "Add Money" : "Withdraw Money"),
        backgroundColor: Colors.redAccent.shade400,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Diamentions.height20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Diamentions.width16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BigText(text: "Previously Given"),
                // GetBuilder<MemberController>(builder: (amount) {
                //   return Text(
                //     amount.member.value.members![].givenAmount.toString(),
                //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                //   );
                // }),
                BigText(text: "${widget.amount} Tk"),
              ],
            ),
          ),
          SizedBox(
            height: Diamentions.height10,
          ),

          // TextFormField(
          //   onChanged: (value) {
          //       if (value.isNotEmpty) {
          //         int newValue = int.parse(value);
          //         memberController.updateGivenAmount(newValue);
          //       }
          //     },
          // ),

          ShadowTextForm(hint: "New Amount", controller: amountController, inputType: TextInputType.number, ),

         
          GetBuilder<MemberController>(
            builder: (member) {
              return AppButton(
                loading: member.addMoneyLoading.value,
                onPress: () {
                  isAddMoney ? submitMoney() : withdrawMoney();
                },
                title: isAddMoney ? "Submit" : "Withdraw",
                buttonColor: Colors.redAccent.shade400,
              );
            },
          ),
        ],
      ),
    );
  }

  void submitMoney() {
    String amount = amountController.text.trim();
    final String url = "${AppConstants.addMoneyUrl}/${widget.id}";
    if (amount.isEmpty) {
      Get.snackbar("Amount Required", "Amount can't be empty");
    } else {
      Map data = {
        "given_amount": amount,
      };
      memberController.addMemberMoney(data, url);
    }
  }

  withdrawMoney() {
    String amount = amountController.text.trim();
    final String url = "${AppConstants.withdrawMoneyUrl}/${widget.id}";
    if (amount.isEmpty) {
      Get.snackbar("Amount Required", "Amount can't be empty");
    } else if (int.parse(amountController.text) > int.parse(widget.amount)) {
      Get.snackbar(
          "You can't withdraw more", "Can not withdraw more than given amount");
    } else {
      Map data = {
        "given_amount": amount,
      };
      memberController.withdrawMemberMoney(data, url);
    }
  }
}
