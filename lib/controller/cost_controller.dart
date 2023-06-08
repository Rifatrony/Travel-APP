import 'package:get/get.dart';
import 'package:travel_app/controller/member_controller.dart';
import 'package:travel_app/data/repository/cost_repo.dart';
import 'package:travel_app/model/cost.dart';
import 'package:travel_app/utils/custom_message.dart';

class CostController extends GetxController {
  final costRepo = CostRepo();
  final cost = CostModel().obs;
  final loading = true.obs;
  final totalLoading = true.obs;
  final addCostLoading = false.obs;

  void setLoading(bool value) {
    loading.value = value;
  }

  void setAddCostLoading(bool value) {
    addCostLoading.value = value;
  }

  void setData(CostModel value) {
    cost.value = value;
  }

  Future<void> getCost(String url) async {
    try {
      costRepo.getCost(url).then((value) {
        setData(value);
        setLoading(false);
        update();
      });
    } catch (e) {
      setLoading(false);
    }
  }

  Future<void> addCost(dynamic data, String url) async {
    setAddCostLoading(true);
    costRepo.addCost(data, url).then((value) {
      if (value['code'] == 200) {
        Get.snackbar("Added", "Cost Added successfully");
        setAddCostLoading(false);
      } else {
        Get.snackbar(value['code'], value['message']);
        setAddCostLoading(false);
      }
    });
  }

  Future<void> deleteMember(String url, String id) async {
    costRepo.deleteCost(url).then((value) {
      if (value['code'] == 200) {
        Get.snackbar(
          "Deleted",
          "Cost Deleted successfully",
        );
        removeCost(id);
      }
      if (value['code'] == 404) {
        Message.snackBar(value['message'],
            title: "Can't delete. Status code + ${value['code']}");
      }
    }).onError((error, stackTrace) {
      Message.snackBar(error.toString(), title: "Can't delete");
    });
  }

  void removeCost(String id) {
    cost.update((model) {
      final index = model?.cost?.indexWhere((cost) => cost.id == id);
      if (index != null && index >= 0) {
        model?.cost?.removeAt(index);
      }
    });

    update();
  }

  int calculateTotalCost() {
    int totalCost = 0;
    cost.value.cost?.forEach((cost) {
      totalCost += cost.amount ?? 0;
    });
    return totalCost;
  }

  int getTotalCost() {
    return cost.value.cost?.length ?? 0;
  }

  double calculateAverageCostPerMember() {
    int totalCost = calculateTotalCost();
    int totalMembers = Get.find<MemberController>().getTotalMembers();
    if (totalMembers > 0) {
      return totalCost.toDouble() / totalMembers.toDouble();
    } else {
      return 0;
    }
  }
}
