import 'package:get/get.dart';
import 'package:users_db/local_storage/boxes.dart';
import 'package:users_db/repo/app_repo.dart';
import '../../models/user.dart';

class AddUserController extends GetxController {
  final isLoading = false.obs;
  final _repo = Get.find<AppRepo>();

  addUser(User user) {
    isLoading.value = true;
    _repo.addUser(user).then((value) async {
      final box = Boxes.getUsers();
      await box.add(user);
      isLoading.value = false;
      Get.back();
    });
  }
}
