// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/controller/auth_controller.dart';
import 'package:travel_app/controller/cost_controller.dart';
import 'package:travel_app/controller/member_controller.dart';
import 'package:travel_app/controller/tour_controller.dart';
import 'package:travel_app/controller/user_controller.dart';
import 'package:travel_app/screen/cost_screen.dart';
import 'package:travel_app/screen/login_screen.dart';
import 'package:travel_app/screen/member_screen.dart';
import 'package:travel_app/screen/tour_screen.dart';
import 'package:travel_app/utils/app_constants.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/big_text.dart';
import 'package:travel_app/widget/reusable_row.dart';
import 'package:travel_app/widget/small_text.dart';
import 'package:travel_app/widget/text_icon.dart';
import 'package:pie_chart/pie_chart.dart';

class DashBoardScreen extends StatefulWidget {
  final String tourName;
  final String tourId;
  final String? start;
  final String? end;
  const DashBoardScreen({
    super.key,
    required this.tourName,
    required this.tourId,
    this.start,
    this.end,
  });

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final authController = Get.put(AuthController());
  final userController = Get.put(UserController());
  final memberController = Get.put(MemberController());
  final costController = Get.put(CostController());
  // final tourController = Get.put(TourController());

  final cost = Get.find<CostController>().calculateTotalCost();

  @override
  void initState() {
    super.initState();
    memberController.getMember("${AppConstants.memberUrl}/${widget.tourId}");
    costController.getCost("${AppConstants.costUrl}/${widget.tourId}");
    memberController.calculateTotalBalance();
    costController.calculateTotalCost();
    memberController.update();
    costController.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App bar container
          Container(
            height: Diamentions.height160,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
              bottom: 20,
            ),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.redAccent.shade400,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 34,
                        backgroundImage: AssetImage(
                          "assets/profile.jpg",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Diamentions.width16,
                    ),
                    Obx(
                      () {
                        return userController.loading.value
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userController.user.value.user!.name
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Diamentions.font16,
                                    ),
                                  ),
                                  Text(
                                    "0${userController.user.value.user!.phone}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Diamentions.font20,
                                    ),
                                  ),
                                  GetBuilder<TourController>(
                                      builder: (controller) {
                                    return Container(
                                      height: 40,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.offAll(
                                                () => const TourScreen());
                                          },
                                          child: Row(
                                            children: [
                                              Text(widget.tourName.toString(),
                                                  style: GoogleFonts.lato(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  )),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              );
                      },
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.purple.shade900,
                      child: IconButton(
                        onPressed: () async {
                          var token = authController.getAccessToken();
                          if (token != null) {
                            authController.removeUser();
                            Get.offAll(() => const LoginScreen());
                          } else {}
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          // Body container
          Container(
            margin: EdgeInsets.only(
              top: Diamentions.height5,
              bottom: Diamentions.height10,
            ),
            height: Diamentions.screenHeight - Diamentions.height160 - 21,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Heading and pie chart contianer
                  Container(
                    margin: EdgeInsets.only(
                      left: Diamentions.width16,
                      right: Diamentions.width16,
                      top: 10,
                      bottom: 20,
                    ),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        // Left side expaned widget
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              totalBalance(),
                              TotalCost(widget: widget),
                              AverageCost(widget: widget),
                              GetBuilder<MemberController>(
                                builder: (memberController) {
                                  return GetBuilder<CostController>(
                                    builder: (costController) {
                                      return BalanceContainer(
                                        onPress: () {
                                          Get.to(
                                            MemberScreen(
                                              id: widget.tourId,
                                              tourName: widget.tourName,
                                            ),
                                          );
                                        },
                                        title: "Remaining Balance",
                                        value:
                                            "${memberController.calculateRemainingBalance()}",
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // Right side pie widget
                        Expanded(
                          flex: 3,
                          child: GetBuilder<MemberController>(
                            builder: (memberController) {
                              return GetBuilder<CostController>(
                                builder: (costController) {
                                  Map<String, double> dataMap = {
                                    "Total Amount": memberController
                                        .calculateTotalBalance()
                                        .toDouble(),
                                    "Total Cost": costController
                                        .calculateTotalCost()
                                        .toDouble(),
                                    "Remaining Amount": memberController
                                        .calculateRemainingBalance()
                                        .toDouble(),
                                    "Total Members": memberController
                                        .getTotalMembers()
                                        .toDouble(),
                                  };

                                  return PieChart(
                                    dataMap: dataMap,
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 12,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.7,
                                    legendOptions: const LegendOptions(
                                      legendPosition: LegendPosition.bottom,
                                    ),
                                    chartValuesOptions:
                                        const ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Account Section
                  Container(
                    margin: EdgeInsets.only(
                      left: Diamentions.width10,
                      right: Diamentions.width10,
                    ),
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 20,
                    ),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade900,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Diamentions.radius30),
                        bottomRight: Radius.circular(Diamentions.radius30),
                        topRight: Radius.circular(Diamentions.radius30),
                        topLeft: Radius.circular(Diamentions.radius30),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Re usable row section start
                        GetBuilder<MemberController>(
                          builder: (memberController) {
                            return ReusableRow(
                              title: "Total Balance",
                              value:
                                  "${memberController.calculateTotalBalance()}",
                            );
                          },
                        ),

                        GetBuilder<MemberController>(
                          builder: (memberController) {
                            return ReusableRow(
                              title: "Total Person",
                              value: "${memberController.getTotalMembers()}",
                            );
                          },
                        ),
                        GetBuilder<CostController>(
                          builder: (costController) {
                            return ReusableRow(
                              title: "Total Cost",
                              value: "${costController.calculateTotalCost()}",
                            );
                          },
                        ),

                        GetBuilder<CostController>(
                          builder: (costController) {
                            return GetBuilder<MemberController>(
                              builder: (memberController) {
                                return ReusableRow(
                                  title: "Per person Cost",
                                  value: costController
                                      .calculateAverageCostPerMember()
                                      .toStringAsFixed(2),
                                );
                              },
                            );
                          },
                        ),
                        GetBuilder<MemberController>(
                          builder: (memberController) {
                            return GetBuilder<CostController>(
                              builder: (costController) {
                                return ReusableRow(
                                  title: "Remaining Balance",
                                  value:
                                      "${memberController.calculateRemainingBalance()}",
                                );
                              },
                            );
                          },
                        ),
                        ReusableRow(
                            title: "Start Date", value: "${widget.start}"),
                        ReusableRow(title: "End Date", value: "${widget.end}"),
                        SizedBox(
                          height: Diamentions.height16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Get.to(CostScreen(id: widget.tourId));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: Diamentions.width5,
                                    right: Diamentions.width5,
                                  ),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade100,
                                    borderRadius: BorderRadius.circular(
                                      Diamentions.radius16,
                                    ),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SmallText(
                                        text: "Cost",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    MemberScreen(
                                      id: widget.tourId,
                                      tourName: widget.tourName,
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: Diamentions.width5,
                                    right: Diamentions.width5,
                                  ),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade100,
                                    borderRadius: BorderRadius.circular(
                                        Diamentions.radius16),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SmallText(
                                        text: "Members",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Diamentions.height10,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: Diamentions.height16,
                  ),

                  // Members section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: Diamentions.width10,
                          right: Diamentions.width10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BigText(text: "Members"),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  MemberScreen(
                                    id: widget.tourId,
                                    tourName: widget.tourName,
                                  ),
                                );
                              },
                              child: const TextIcon(
                                text: "See All",
                                icon: Icons.arrow_forward_ios,
                                iconSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return memberController.loading.value
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                  bottom: Diamentions.height10,
                                  left: Diamentions.width10,
                                  right: Diamentions.width10,
                                ),
                                itemCount: memberController
                                            .member.value.members!.length >
                                        3
                                    ? 3
                                    : memberController
                                        .member.value.members!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      top: Diamentions.height10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      ),
                                      color: Colors.purple.shade900,
                                    ),
                                    child: ListTile(
                                      onTap: () {},
                                      contentPadding: const EdgeInsets.all(10),
                                      title: BigText(
                                        text: memberController
                                            .member.value.members![index].name
                                            .toString(),
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      subtitle: SmallText(
                                        text:
                                            "0${memberController.member.value.members![index].phone}",
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      leading: const CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                          "assets/profile.jpg",
                                        ),
                                      ),
                                      // trailing: IconButton(
                                      //   onPressed: () {},
                                      //   icon: const Icon(
                                      //     Icons.more_vert,
                                      //   ),
                                      //   color: Colors.white,
                                      // ),
                                    ),
                                  );
                                },
                              );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GetBuilder<MemberController> totalBalance() {
    return GetBuilder<MemberController>(
      builder: (controller) {
        return BalanceContainer(
          onPress: () {
            Get.to(
              MemberScreen(
                id: widget.tourId,
                tourName: widget.tourName,
              ),
            );
          },
          title: "Total Balance",
          value:
              "${controller.calculateTotalBalance()} (${controller.getTotalMembers()} person)",
        );
      },
    );
  }
}

class AverageCost extends StatelessWidget {
  const AverageCost({
    super.key,
    required this.widget,
  });

  final DashBoardScreen widget;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostController>(
      builder: (costController) {
        return GetBuilder<MemberController>(
          builder: (memberController) {
            return BalanceContainer(
              onPress: () {
                Get.to(CostScreen(id: widget.tourId));
              },
              title: "Average Cost",
              value: costController
                  .calculateAverageCostPerMember()
                  .toStringAsFixed(2),
            );
          },
        );
      },
    );
  }
}

class TotalCost extends StatelessWidget {
  const TotalCost({
    super.key,
    required this.widget,
  });

  final DashBoardScreen widget;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostController>(
      builder: (controller) {
        return BalanceContainer(
          onPress: () {
            Get.to(CostScreen(id: widget.tourId));
          },
          title: "Total Cost",
          value: "${controller.calculateTotalCost()}",
        );
      },
    );
  }
}

class BalanceContainer extends StatelessWidget {
  final String title, value;
  final VoidCallback? onPress;
  const BalanceContainer(
      {super.key, required this.title, required this.value, this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(
          top: Diamentions.height10,
          bottom: Diamentions.height10,
          left: Diamentions.width5,
          right: Diamentions.width5,
        ),
        padding: EdgeInsets.only(
          top: Diamentions.height10,
          bottom: Diamentions.height10,
        ),
        decoration: BoxDecoration(
            color: Colors.purple.shade900,
            borderRadius: BorderRadius.circular(Diamentions.radius16)),
        width: double.maxFinite,
        child: Column(
          children: [
            BigText(
              text: title,
              size: 12,
              color: Colors.white,
            ),
            const SizedBox(
              height: 2,
            ),
            BigText(
              text: value,
              size: 14,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
