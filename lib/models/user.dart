import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
  });
  @HiveField(0)
  late final String? id;
  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String email;
  @HiveField(3)
  late final String mobile;
  @HiveField(4)
  late final String gender;

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['gender'] = gender;
    return data;
  }
}
