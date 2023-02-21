import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:users_db/routes/routes.dart';
import '../modules/add_user/add_user.dart';
import '../modules/add_user/add_user_binding.dart';
import '../modules/home/home.dart';
import '../modules/home/home_binding.dart';

class PageRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    final route = settings.name;
    //final args = settings.arguments;
    switch (route) {
      case Routes.HOME:
        return GetPageRoute(
            routeName: Routes.HOME,
            page: () => const Home(),
            binding: HomeBinding());
      case Routes.ADD_USER:
        return GetPageRoute(
            routeName: Routes.HOME,
            page: () => AddUser(),
            binding: AddUserBinding());
    }
    return null;
  }
}
