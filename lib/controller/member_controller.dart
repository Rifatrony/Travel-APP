import 'package:get/get.dart';
import 'package:travel_app/data/repository/member_repo.dart';
import 'package:travel_app/model/member.dart';
import 'package:travel_app/utils/custom_message.dart';

class MemberController extends GetxController {
  final memberRepo = MemberRepo();
  final member = MemberModel().obs;
  final loading = true.obs;
  final addLoading = false.obs;
  final addMoneyLoading = false.obs;

  void setLoading(bool value) {
    loading.value = value;
  }

  void setAddLoading(bool value) {
    addLoading.value = value;
  }

  void setAddMoneyLoading(bool value) {
    addMoneyLoading.value = value;
  }

  void setData(MemberModel value) {
    member.value = value;
  }

  Future<void> getMember(String url) async {
    try {
      memberRepo.getMember(url).then((value) {
        setData(value);
        setLoading(false);
        update();
      });
    } catch (e) {
      setLoading(false);
    }
  }

  Future<void> addMember(dynamic data, String url) async {
    setAddLoading(true);
    memberRepo.addMember(data, url).then((value) {
      if (value['code'] == 400) {
        Get.snackbar("Error Occured with status code 400", value['message']);
        setAddLoading(false);
      } else if (value['code'] == 200) {
        Get.snackbar(
            "Member added successfully", "New member added to the tour");
        setAddLoading(false);
      } else {
        Get.snackbar("Error Occured with status code 500", value['message']);
        setAddLoading(false);
      }
    }).onError((error, stackTrace) {
      Get.snackbar("title", error.toString());
      setAddLoading(false);
    });
  }

  Future<void> addMemberMoney(dynamic data, String url) async {
    setAddLoading(true);
    await memberRepo.addMemberMoney(data, url).then((value) {
      if (value['code'] == 200) {
        Message.snackBar("New amount added successfully",
            title: "Amount added");
        setAddMoneyLoading(false);
      } else if (value['code'] == 404) {
        Message.snackBar(value['code'], title: value['message']);
        setAddMoneyLoading(false);
      } else {
        Get.snackbar(
            "Error with status code ${value['code']}", value['message']);
        setAddMoneyLoading(false);
      }
    }).onError((error, stackTrace) {
      Get.snackbar("Error Occure", error.toString());
      setAddMoneyLoading(false);
    });
    update();
  }

  Future<void> withdrawMemberMoney(dynamic data, String url) async {
    setAddLoading(true);
    await memberRepo.withdrawMemberMoney(data, url).then((value) {
      if (value['code'] == 200) {
        Message.snackBar("Amount withdraw successfully",
            title: "Amount withdraw");
        setAddMoneyLoading(false);
      } else if (value['code'] == 404) {
        Message.snackBar(value['code'], title: value['message']);
        setAddMoneyLoading(false);
      } else {
        Get.snackbar(
            "Error with status code ${value['code']}", value['message']);
        setAddMoneyLoading(false);
      }
    }).onError((error, stackTrace) {
      Get.snackbar("Error Occure", error.toString());
      setAddMoneyLoading(false);
    });
    update();
  }

  Future<void> deleteMember(String url, String id) async {
    memberRepo.deleteMember(url).then((value) {
      if (value['code'] == 200) {
        Get.snackbar(
          "Deleted",
          "Member Deleted successfully",
        );
        removeMember(id);
      }
      if (value['code'] == 404) {
        Message.snackBar(value['message'], title: "Can't delete. Status code + ${value['code']}");
      }
    }).onError((error, stackTrace) {
        Message.snackBar(error.toString(), title: "Can't delete");
    });
  }

  void removeMember(String id) {
    member.update((model) {
      final index = model?.members?.indexWhere((member) => member.id == id);
      if (index != null && index >= 0) {
        model?.members?.removeAt(index);
      }
    });
    update();
  }

  incrementGivenAmount(int value) {
    for (var member in member.value.members!) {
      member.givenAmount = member.givenAmount! + value;
    }
    // Update the state to reflect the changes
    update();
  }

  void updateGivenAmount(int index, int newValue) {
    member.value.members![index].givenAmount = newValue;
    update();
  }

  int getTotalMembers() {
    return member.value.members?.length ?? 0;
  }

  int calculateTotalBalance() {
    int totalBalance = 0;
    member.value.members?.forEach((member) {
      totalBalance += member.givenAmount ?? 0;
    });
    return totalBalance;
  }


}
