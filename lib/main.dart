
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stellora/view/LoginPage.dart';
import 'package:stellora/view/RegisterPage.dart';
import 'package:stellora/view/SettingPage.dart';
import 'controller/LoginController.dart';
import 'controller/Login_Binding.dart';
import 'controller/RegisterController.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => SharedPreferences.getInstance());

  // final userController = Get.put(UserController());
  // await userController.loadUserData();
  // await userController.initializeUser();

  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => RegisterController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffF5F5F5),
          drawerTheme: DrawerThemeData(backgroundColor: Color(0xffF5F5F5))),
      debugShowCheckedModeBanner: false,
      title: 'My App',
      getPages: [
        GetPage(
          name: '/Login',
          page: () => LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: ("/Register"),
          page: () => RegisterPage(),
        ),
        GetPage(
          name: ("/Setting"),
          page: () => Setting(),
        ),
      ],
      initialRoute: '/Setting',
    );
  }
}