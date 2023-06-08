// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/tour_controller.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_button.dart';
import 'package:travel_app/widget/shadow_text_form.dart';

class AddTourScreen extends StatefulWidget {
  final String? id;
  final String? name;
  final String? startDate;
  final String? endDate;
  const AddTourScreen({
    super.key,
    this.id,
    this.name,
    this.startDate,
    this.endDate,
  });

  @override
  State<AddTourScreen> createState() => _AddTourScreenState();
}

class _AddTourScreenState extends State<AddTourScreen> {
  final tourController = Get.put(TourController());
  final nameController = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      isEdit = true;
      nameController.text = widget.name.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Update Tour" : "Add Tour"),
        backgroundColor: Colors.redAccent.shade400,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Diamentions.height20,
          ),
          ShadowTextForm(
            hint: "Name",
            controller: nameController,
            inputType: TextInputType.name,
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
                      "Select start date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      _startDate != null
                          ? "${_startDate.day.toString().padLeft(2, '0')}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.year.toString()}"
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
                      "Select End date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      _endDate != null
                          ? "${_endDate.day.toString().padLeft(2, '0')}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.year.toString()}"
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
                    _endDatePicker();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                )
              ],
            ),
          ),
          SizedBox(
            height: Diamentions.height20,
          ),
          GetBuilder<TourController>(builder: (controller) {
            return AppButton(
              loading: tourController.addLoading.value,
              onPress: () {
                submitData();
              },
              title: isEdit ? "Update" : "Submit",
              buttonColor: Colors.redAccent.shade400,
            );
          })
        ],
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(200),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _startDate = value!;
      });
    });
  }

  void _endDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(200),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _endDate = value!;
      });
    });
  }

  void submitData() {
    String name = nameController.text.toString().trim();
    String startDate = _startDate != null
        ? "${_startDate.day.toString().padLeft(2, '0')}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.year.toString()}"
        : '';
    String endDate = _endDate != null
        ? "${_endDate.day.toString().padLeft(2, '0')}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.year.toString()}"
        : '';

    if (name.isEmpty) {
      Get.snackbar("Name Required", "Write your name");
    } else {
      Map data = {
        "name": name,
        "start_date": startDate,
        "end_date": endDate,
      };
      tourController.addNewTour(data);
    }
  }
}
