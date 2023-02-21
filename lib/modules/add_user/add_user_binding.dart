import 'package:get/get.dart';
import 'package:users_db/modules/add_user/add_user_controller.dart';

class AddUserBinding extends Bindings {
  @override
  void dependencies() {
        Get.lazyPut(() => AddUserController(), fenix: true);

  }
}
