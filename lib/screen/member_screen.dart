import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/member_controller.dart';
import 'package:travel_app/model/member.dart';
import 'package:travel_app/screen/add_member_screen.dart';
import 'package:travel_app/screen/money_screen.dart';
import 'package:travel_app/utils/app_constants.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_floating_action_button.dart';
import 'package:travel_app/widget/big_text.dart';
import 'package:travel_app/widget/reusable_row.dart';
import 'package:travel_app/widget/small_text.dart';

class MemberScreen extends StatefulWidget {
  final String id;
  final String tourName;
  const MemberScreen({
    super.key,
    required this.id,
    required this.tourName,
  });

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final memberController = Get.put(MemberController());

  @override
  void initState() {
    super.initState();
    fetchMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Members"),
        elevation: 0,
        backgroundColor: Colors.redAccent.shade400,
      ),
      body: GetBuilder<MemberController>(
        builder: (memberController) {
          // final reversedMembers = memberController.member.value.members!.reversed;
          final reversedMembers =
              memberController.member.value.members!.reversed.toList();
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: Diamentions.width10,
              right: Diamentions.width10,
              top: Diamentions.height5,
              bottom: Diamentions.height10,
            ),
            itemCount: reversedMembers.length,
            itemBuilder: (context, index) {
              final Member member = reversedMembers[index];
              return Container(
                margin: EdgeInsets.only(
                  left: Diamentions.width5,
                  right: Diamentions.width5,
                  top: Diamentions.height10,
                  bottom: Diamentions.height10,
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Diamentions.radius20,
                  ),
                  color: Colors.purple.shade900,
                ),
                child: Column(
                  children: [
                    // Name and picture container
                    Container(
                      margin: EdgeInsets.only(
                        left: Diamentions.width10,
                        right: Diamentions.width10,
                        top: Diamentions.height20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NameRow(
                                name: member.name.toString(),
                                serial: "${index + 1}.",
                              ),
                              SizedBox(
                                height: Diamentions.height5,
                              ),
                              SmallText(
                                text: "0${member.phone}",
                                size: Diamentions.font16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          PopupMenuButton(
                            color: Colors.white,
                            onSelected: (value) {
                              if (value == 'edit') {
                                navigateToEditMemberPage(index);
                              } else if (value == 'delete') {
                                final url =
                                    "${AppConstants.deleteMemberUrl}/${member.id}";
                                memberController.deleteMember(
                                    url, member.id.toString());
                              } else if (value == 'add-money') {
                                navigateToAddMoneyPage(index);
                              } else if (value == 'withdraw-money') {
                                navigateToWithdrawMoneyPage(index);
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: "edit",
                                  child: Text("Edit"),
                                ),
                                const PopupMenuItem(
                                  value: "delete",
                                  child: Text("Delete"),
                                ),
                                const PopupMenuItem(
                                  value: "add-money",
                                  child: Text("Add money"),
                                ),
                                const PopupMenuItem(
                                  value: "withdraw-money",
                                  child: Text("Withdraw money"),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),

                    SmallText(
                      text: widget.tourName,
                      color: Colors.black,
                      size: 18,
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        left: Diamentions.width10,
                        right: Diamentions.width10,
                        bottom: Diamentions.height20,
                        top: Diamentions.height10,
                      ),
                      child: Column(
                        children: [
                          ReusableRow(
                            title: "Total Given",
                            value: member.givenAmount.toString(),
                          ),
                          GetBuilder<MemberController>(builder: (controller) {
                            final totalMembers = controller.getTotalMembers();
                            final totalBalance =
                                controller.calculateTotalBalance();
                            final averageBalance = totalMembers > 0
                                ? totalBalance / totalMembers
                                : 0;

                            // Format the average balance to two decimal places
                            final formattedAverageBalance =
                                averageBalance.toStringAsFixed(2);

                            // final returnAmount = givenAmount - double.parse(formattedAverageBalance);

                            return ReusableRow(
                              title: "Per person cost (not done)",
                              value: formattedAverageBalance,
                            );
                          }),
                          GetBuilder<MemberController>(builder: (controller) {

                            final givenAmount = member.givenAmount;

                            final totalMembers = controller.getTotalMembers();
                            final totalBalance =
                                controller.calculateTotalBalance();
                            final averageBalance = totalMembers > 0
                                ? totalBalance / totalMembers
                                : 0;

                            // Format the average balance to two decimal places
                            final formattedAverageBalance =
                                averageBalance.toStringAsFixed(2);
                            final myBalance = member.givenAmount!;
                            final returnBalance = myBalance > 0
                                ? myBalance - averageBalance
                                : 0;

                            return ReusableRow(
                              title: "Get Return",
                              value: "$returnBalance",
                              valueColor: returnBalance > 0 ? Colors.white : Colors.redAccent.shade400,
                              valueSize: returnBalance > 0 ? 14 : 18,
                              valueFontWidget: returnBalance > 0 ? FontWeight.normal : FontWeight.bold,
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        title: "Add Member",
        onPress: () {
          navigateToAddMemberPage();
        },
        color: Colors.redAccent.shade400,
      ),
    );
  }

  void fetchMember() {
    memberController.getMember("${AppConstants.memberUrl}/${widget.id}");
  }

  Future<void> navigateToAddMemberPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddMemberScreen(
        id: widget.id,
      ),
    );
    await Navigator.push(context, route);
    fetchMember();
  }

  Future<void> navigateToEditMemberPage(int index) async {
    final reversedMembers =
        memberController.member.value.members!.reversed.toList();

    final Member member = reversedMembers[index];

    final route = MaterialPageRoute(
      builder: (context) => AddMemberScreen(
        id: widget.id,
        name: member.name.toString(),
        phone: "0${member.phone}",
        amount: member.givenAmount.toString(),
      ),
    );
    await Navigator.push(context, route);
    fetchMember();
  }

  Future<void> navigateToAddMoneyPage(int index) async {
    final reversedMembers =
        memberController.member.value.members!.reversed.toList();

    final Member member = reversedMembers[index];

    final route = MaterialPageRoute(
      builder: (context) => MoneyScreen(
        id: member.id.toString(),
        amount: member.givenAmount.toString(),
        type: "add",
      ),
    );
    await Navigator.push(context, route);
    fetchMember();
  }

  Future<void> navigateToWithdrawMoneyPage(int index) async {
    final reversedMembers =
        memberController.member.value.members!.reversed.toList();

    final Member member = reversedMembers[index];

    final route = MaterialPageRoute(
      builder: (context) => MoneyScreen(
        id: member.id.toString(),
        amount: member.givenAmount.toString(),
        type: "remove",
      ),
    );
    await Navigator.push(context, route);
    fetchMember();
  }
}

class NameRow extends StatelessWidget {
  final String serial, name;
  const NameRow({
    super.key,
    required this.serial,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmallText(
          text: serial,
          size: Diamentions.font20,
          color: Colors.white,
        ),
        SizedBox(
          width: Diamentions.width5,
        ),
        BigText(
          text: name,
          size: Diamentions.font20,
          color: Colors.white,
        ),
      ],
    );
  }
}
