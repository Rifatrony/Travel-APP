// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/cost_controller.dart';
import 'package:travel_app/utils/app_constants.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';

class AddCost extends StatefulWidget {
  final String tourId;

  final int? amount;
  final String? reason;
  final String? date;
  const AddCost({
    super.key,
    required this.tourId,
    this.amount,
    this.reason,
    this.date,
  });

  @override
  State<AddCost> createState() => _AddCostState();
}

class _AddCostState extends State<AddCost> {
  final amountController = TextEditingController();
  final reasonController = TextEditingController();

  final costController = Get.put(CostController());

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.reason != null) {
      isEdit = true;
      final amount = widget.amount!;
      final reason = widget.reason!;
      final date = widget.date!;

      amountController.text = amount.toString();
      reasonController.text = reason.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Cost" : "Add Cost"),
        backgroundColor: Colors.redAccent.shade400,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Diamentions.height20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Diamentions.width20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: Diamentions.width16,
                    right: Diamentions.width16,
                    top: Diamentions.height10,
                    bottom: Diamentions.height10,
                  ),
                  hintText: "Amount",
                ),
              ),
            ),
          ),
          SizedBox(
            height: Diamentions.height10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Diamentions.width20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                maxLines: 4,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                controller: reasonController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: Diamentions.width16,
                    right: Diamentions.width16,
                  ),
                  hintText: "Reason",
                ),
              ),
            ),
          ),
          SizedBox(
            height: Diamentions.height10,
          ),
          Obx(() {
            return AppButton(
              loading: costController.addCostLoading.value,
              onPress: () {
                isEdit ? updateData() : submitData();
              },
              title: isEdit ? "Update" : "Submit",
              buttonColor: Colors.redAccent.shade400,
            );
          })
        ],
      ),
    );
  }

  void submitData() {
    String amount = amountController.text.trim();
    String reason = reasonController.text.trim();

    if (amount.isEmpty) {
      Get.snackbar(
        "Amount Required",
        "Write amount here",
      );
    } else if (reason.isEmpty) {
      Get.snackbar(
        "Amount Required",
        "Write amount here",
      );
    } else {
      Map data = {
        "amount": amount,
        "reason": reason,
        "date": "06/02/2023",
      };
      costController.addCost(
        data,
        "${AppConstants.addCostUrl}/${widget.tourId}",
      );
    }
  }

  void updateData() {}
}
