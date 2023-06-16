import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/cost_controller.dart';
import 'package:travel_app/screen/add_cost.dart';
import 'package:travel_app/utils/app_constants.dart';
import 'package:travel_app/utils/diamention.dart';
import 'package:travel_app/widget/app_floating_action_button.dart';
import 'package:travel_app/widget/big_text.dart';
import 'package:travel_app/widget/small_text.dart';

class CostScreen extends StatefulWidget {
  final String id;
  const CostScreen({
    super.key,
    required this.id,
  });

  @override
  State<CostScreen> createState() => _CostScreenState();
}

class _CostScreenState extends State<CostScreen> {
  final costController = Get.put(CostController());

  @override
  void initState() {
    super.initState();

    fetchCost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cost",
        ),
        backgroundColor: Colors.redAccent.shade400,
        elevation: 0,
      ),
      body: GetBuilder<CostController>(
        builder: (costController) {
          if (costController.cost.value.cost != null) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                bottom: Diamentions.height10,
                left: Diamentions.width10,
                right: Diamentions.width10,
              ),
              itemCount: costController.cost.value.cost!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: Diamentions.height10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Diamentions.radius16,
                    ),
                    color: Colors.purple.shade900,
                  ),
                  child: ListTile(
                    onTap: () {},
                    minVerticalPadding: 20,
                    horizontalTitleGap: 0,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text:
                              "${costController.cost.value.cost![index].date} (${costController.cost.value.cost![index].amount} Tk)",
                          size: Diamentions.font16,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: Diamentions.height5,
                        ),
                      ],
                    ),
                    subtitle: SmallText(
                      text: costController.cost.value.cost![index].reason
                          .toString(),
                      size: 12,
                      color: Colors.white,
                    ),
                    leading: BigText(
                      text: "${index + 1}.",
                      color: Colors.white,
                      size: 26,
                    ),
                    trailing: PopupMenuButton(
                      color: Colors.white,
                      onSelected: (value) {
                        if (value == 'edit') {
                          navigateToEditCostPage(index);
                        } else {
                          final url =
                              "${AppConstants.deleteCostUrl}/${costController.cost.value.cost![index].id}";
                          costController.deleteMember(
                            url,
                            costController.cost.value.cost![index].id
                                .toString(),
                          );
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
                        ];
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        title: "Add Cost",
        color: Colors.redAccent.shade400,
        onPress: () {
          navigateToCostPage();
        },
      ),
    );
  }

  void fetchCost() {
    costController.getCost("${AppConstants.costUrl}/${widget.id}");
  }

  Future<void> navigateToCostPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddCost(
        tourId: widget.id,
      ),
    );
    await Navigator.push(context, route);
    fetchCost();
  }

  Future<void> navigateToEditCostPage(int index) async {
    final route = MaterialPageRoute(
      builder: (context) => AddCost(
        tourId: widget.id,
        amount: costController.cost.value.cost![index].amount,
        reason: costController.cost.value.cost![index].reason,
        date: costController.cost.value.cost![index].date,
      ),
    );
    await Navigator.push(context, route);
    fetchCost();
  }

  void deleteCost(String id) {
    costController.removeCost(id);
  }
}
