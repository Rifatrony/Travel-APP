import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/controller/tour_controller.dart';
import 'package:travel_app/screen/dashboard.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_floating_action_button.dart';
import 'package:travel_app/widget/big_text.dart';
import 'package:travel_app/widget/small_text.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  final tourController = Get.put(TourController());

  // @override
  // void initState() {
  //   super.initState();
  //   // ifExistTour();
  // }

  Future<void> ifExistTour() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
    final tourName = prefs.getString('tourName');

    if (id != null) {
      Get.offAll(
        DashBoardScreen(
          tourName: tourName!,
          tourId: id,
        ),
      );
    } else {
      Get.offAll(const TourScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a tour"),
        backgroundColor: Colors.redAccent.shade400,
        elevation: 0,
      ),
      body: GetBuilder<TourController>(
        builder: (tourController) {
          return tourController.loading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: EdgeInsets.only(
                    left: Diamentions.width10,
                    right: 10,
                    top: 10,
                  ),
                  itemCount: tourController.tour.value.tour!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //Get.toNamed(RouteHelper.getDashboard(tourController.tourList[index].id.toString(), index));
                        tourController.saveTour(
                          tourController.tour.value.tour![index].id.toString(),
                          tourController.tour.value.tour![index].name
                              .toString(),
                        );
                        Get.to(
                          DashBoardScreen(
                            tourName: tourController
                                .tour.value.tour![index].name
                                .toString(),
                            tourId: tourController.tour.value.tour![index].id
                                .toString(),
                            start: tourController
                                .tour.value.tour![index].startDate
                                .toString(),
                            end: tourController.tour.value.tour![index].endDate
                                .toString(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: Diamentions.width10,
                          right: Diamentions.width10,
                          top: Diamentions.height10,
                          bottom: Diamentions.height10,
                        ),
                        margin: EdgeInsets.only(
                          bottom: Diamentions.height10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.purple.shade900,
                        ),
                        child: ListTile(
                          leading: Text(
                            "${index + 1}.",
                            style: TextStyle(
                              fontSize: Diamentions.font20,
                              color: Colors.white,
                            ),
                          ),
                          title: BigText(
                            text: tourController.tour.value.tour![index].name
                                .toString(),
                            color: Colors.white,
                          ),
                          subtitle: SmallText(
                            text:
                                "From ${tourController.tour.value.tour![index].startDate} to ${tourController.tour.value.tour![index].endDate}",
                            color: Colors.white54,
                          ),
                          horizontalTitleGap: 0,
                          trailing: PopupMenuButton(
                            color: Colors.white,
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: "edit",
                                child: Text("Edit"),
                              ),
                              const PopupMenuItem(
                                value: "delete",
                                child: Text("Delete"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        title: "Add Tour",
        onPress: () {},
        color: Colors.redAccent.shade400,
        fontSize: 14,
      ),
    );
  }
}
