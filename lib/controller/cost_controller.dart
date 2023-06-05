import 'package:get/get.dart';
import 'package:travel_app/data/repository/cost_repo.dart';
import 'package:travel_app/model/cost.dart';

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

  // Future<int> calculateTotalCost()  async {
  //   totalLoading.value = true;
  //   int totalCost = 0;
  //   cost.value.cost?.forEach((cost) {
  //     totalCost += cost.amount ?? 0;
  //   });
  //   totalLoading.value = false;
  //   update();
  //   return totalCost;
  // }

  Future<int> calculateTotalCost() async {
  totalLoading.value = true;
  int totalCost = 0;
  final costList = cost.value.cost ?? []; // Use null-aware operator to handle null value
  costList.forEach((cost) {
    totalCost += cost.amount ?? 0;
  });
  totalLoading.value = false;
  update();
  return totalCost;
}

  // final costModel = CostModel().obs;

  void removeCost(String id) {
    cost.update((model) {
      final index = model?.cost?.indexWhere((cost) => cost.id == id);
      if (index != null && index >= 0) {
        model?.cost?.removeAt(index);
      }
    });
  }

  // int calculateTotalCost() {
  //   int totalBalance = 0;
  //   cost.value.cost?.forEach((cost) {
  //     totalBalance += cost.amount ?? 0;
  //   });
  //   return totalBalance;
  // }

}
