import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_db/models/user.dart';
import 'package:users_db/modules/add_user/add_user_controller.dart';

class AddUser extends GetView<AddUserController> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _genderController = TextEditingController();

  AddUser({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  type: TextInputType.name,
                  label: 'Name',
                  icon: Icons.person,
                  validatorCallBack: (value) {
                    if (value!.length < 5) {
                      return 'Name cannot be less than 5 characters';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                  icon: Icons.email,
                  validatorCallBack: (value) {
                    if (!GetUtils.isEmail(value!)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _mobileController,
                  type: TextInputType.phone,
                  label: 'Mobile',
                  icon: Icons.mobile_friendly,
                  validatorCallBack: (value) {
                    if (value!.length < 10) {
                      return 'Mobile cannot be lesser than 10 characters';
                    }
                    if (value.length > 10) {
                      return 'Mobile cannot be greater than 10 characters';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _genderController,
                  type: TextInputType.text,
                  label: 'Gender',
                  icon: Icons.male_outlined,
                  validatorCallBack: (value) {
                    if (value!.length < 4) {
                      return 'Enter a valid Gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(Get.width * 0.4, 50.0),
                            shape: const StadiumBorder(),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            final isFormValid =
                                _formKey.currentState!.validate();
                            if (isFormValid) {
                              controller.addUser(User(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  mobile: _mobileController.text.trim(),
                                  gender: _genderController.text.trim()));
                            }
                          },
                          label: Text(
                            'Add',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontSize: 18.0, color: Colors.white),
                          ),
                        );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? Function(String?) validatorCallBack;
  final TextInputType type;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.validatorCallBack,
    required this.type,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          label: Text(label),
        ),
        validator: validatorCallBack,
      ),
    );
  }
}
