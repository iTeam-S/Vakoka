import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybn/controllers/api.dart';
import 'package:mybn/views/home.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppController extends GetxController {
  final ApiController apiController = Get.put(ApiController());

  // ************* LOGIN *********************
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(RoundedLoadingButtonController controller, String email,
      String passwd) async {
    var res = await apiController.login(email, passwd);
    if (res[0]) {
      Timer(Duration(seconds: 1), () {
        Get.off(HomePage());
      });
      controller.success();
    } else {
      Get.snackbar(
        "Erreur",
        "${res[1]}",
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
  }

  // *****************************************
}
