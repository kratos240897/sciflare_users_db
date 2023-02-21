import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:users_db/local_storage/boxes.dart';
import 'package:users_db/models/user.dart';
import 'package:users_db/modules/home/home_controller.dart';
import 'package:users_db/routes/routes.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: Boxes.getUsers().listenable(),
        builder: (context, Box<User> box, child) {
          final users = box.values.toList().cast<User>();
          if (users.isNotEmpty) {
            return ListView.separated(
                itemCount: users.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1.0,
                  );
                },
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      user.email,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 14.0,
                                color: Colors.grey.shade700,
                              ),
                    ),
                  );
                });
          } else {
            return Center(
              child: Text(
                'No users added!',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 18.0),
              ),
            );
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_USER),
        child: const Icon(Icons.add),
      ),
    );
  }
}
