import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mybn/controllers/app.dart';
import 'package:mybn/models/users.dart';
import 'package:mybn/views/home.dart';
import 'package:mybn/views/login.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppController appController = Get.put(AppController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    Widget verif() {
      if (box.hasData('user')) {
        Map usrTmp = box.read('user');
        print(usrTmp);
        appController.user = User(
          nom: usrTmp['nom'],
          admin: usrTmp['admin'],
          id: usrTmp['id'],
          token: usrTmp['token'],
        );
        return HomePage();
      }
      return LoginPage();
    }

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MYBN',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => verif(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        });
  }
}
