import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:users_db/constants/constants.dart';
import 'package:users_db/models/user.dart';
import 'package:users_db/service/api_service.dart';

class AppRepo {
  final _api = Get.find<ApiService>();
  Future<bool> addUser(User user) async {
    try {
      await _api.postRequest(Constants.USERS_ENDPOINT, user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> getusers() async {
    try {
      final List<User> users = [];
      final res = await _api.getRequest(Constants.USERS_ENDPOINT, {});
      for (var element in res.data) {
        users.add(User.fromJson(element));
      }
      return users;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
