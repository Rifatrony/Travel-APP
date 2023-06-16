// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/cost_controller.dart';
import 'package:travel_app/controller/member_controller.dart';
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
  final memberController = Get.put(MemberController());

  bool isEdit = false;
  DateTime _dateTime = DateTime.now();

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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Remaining Balance ",
                  style: TextStyle(fontSize: 18),
                ),
                Text(memberController.calculateRemainingBalance().toString(),
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
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
            height: Diamentions.height20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Diamentions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select a date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      _dateTime != null
                          ? "${_dateTime.day.toString().padLeft(2, '0')}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.year.toString()}"
                          : '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                )
              ],
            ),
          ),
          SizedBox(
            height: Diamentions.height16,
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

    if (memberController.calculateRemainingBalance().toString().isEmpty) {
      Get.snackbar(
        "Amount not found for cost",
        "Add some member first and add money with the member",
      );
    } else if (amount.isEmpty) {
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
        "date": _dateTime != null
            ? "${_dateTime.day.toString().padLeft(2, '0')}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.year.toString()}"
            : '',
      };
      costController.addCost(
        data,
        "${AppConstants.addCostUrl}/${widget.tourId}",
      );
    }
  }

  void updateData() {}

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(200),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }
}
