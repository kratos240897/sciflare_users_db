import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:users_db/constants/constants.dart';
import 'package:users_db/models/user.dart';
import 'package:users_db/repo/app_repo.dart';
import 'package:users_db/routes/rotuer.dart';
import 'package:users_db/routes/routes.dart';
import 'package:loggy/loggy.dart';
import 'package:users_db/service/api_service.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(logPrinter: const PrettyPrinter());
  await setSystemPreference();
  await initHive();
  await inject();
}

Future<void> setSystemPreference() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>(Constants.DB_NAME);
}

Future<void> inject() async {
  Get.lazyPut(() => ApiService(), fenix: true);
  Get.lazyPut(() => AppRepo(), fenix: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users DB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily
      ),
      initialRoute: Routes.HOME,
      onGenerateRoute: PageRouter.onGenerateRoute,
    );
  }
}
