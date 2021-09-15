import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mybn/controllers/api.dart';
import 'package:mybn/models/users.dart';
import 'package:mybn/translation.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppController extends GetxController {
  final ApiController apiController = Get.put(ApiController());
  final box = GetStorage();
  // ************* LOGIN *********************
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // Utilisateur
  late User user;
  String lang = 'fr';

  void login(RoundedLoadingButtonController controller, String email,
      String passwd) async {
    try {
      var res = await apiController.login(email, passwd);
      if (res[0]) {
        Timer(Duration(seconds: 1), () {
          Map usrTmp = {
            'email': email,
            'admin': res[1]['admin'],
            'nom': res[1]['nom'],
            'id': res[1]['id'],
            'token': res[1]['token']
          };
          box.write('user', usrTmp);
          box.save();
          Get.offNamed('/home');
        });
        controller.success();
      } else {
        Get.snackbar(
          "Erreur",
          "${translate[res[1]]![lang]}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.red,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          duration: Duration(seconds: 2),
        );
        controller.error();
        Timer(Duration(seconds: 2), () {
          controller.reset();
        });
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "${translate["erreur"]![lang]}",
        "${translate["erreur_produite"]![lang]}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.red,
        borderRadius: 10,
        borderWidth: 2,
        barBlur: 0,
        duration: Duration(seconds: 2),
      );
      controller.reset();
    }
  }

  // *****************************************

  // HOME
}
