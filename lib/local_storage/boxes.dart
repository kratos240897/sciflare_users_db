import 'package:hive/hive.dart';
import 'package:users_db/constants/constants.dart';
import 'package:users_db/models/user.dart';

class Boxes {
  static Box<User> getUsers() => Hive.box(Constants.DB_NAME);
}