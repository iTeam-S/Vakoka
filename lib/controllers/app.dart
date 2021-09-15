import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mybn/controllers/api.dart';
import 'package:mybn/controllers/upload.dart';
import 'package:mybn/models/users.dart';
import 'package:mybn/translation.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppController extends GetxController {
  final ApiController apiController = Get.put(ApiController());
  final UploadController uploadController = Get.put(UploadController());
  final box = GetStorage();
  // ************* LOGIN *********************
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // Utilisateur
  late User user;
  String lang = 'fr';

// Uploader les fic
  FocusNode focus = FocusNode();

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
          user = User(
              id: usrTmp['id'],
              nom: usrTmp['nom'],
              token: usrTmp['token'],
              email: email,
              admin: usrTmp['admin']);
          box.write('user', usrTmp);
          box.save();
          Get.offNamed('/home');
        });
        controller.success();
      } else {
        Get.snackbar(
          "Erreur",
          translate(res[1], lang),
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
        translate("erreur", lang),
        translate("erreur_produite", lang),
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

  void logout() {
    box.remove('user');
    Get.offNamed('/login');
  }

  Future<bool> process(RoundedLoadingButtonController btnController) async {
    try {
      uploadController.uploadPourcent = 0.0;
      Get.bottomSheet(GetBuilder<UploadController>(
          builder: (_) => Container(
              margin: EdgeInsets.symmetric(
                vertical: Get.height * 0.02,
                horizontal: Get.width * 0.06,
              ),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                value: uploadController.uploadPourcent,
              ))));
      var res = await apiController.uploadContent(
          user.id,
          user.token,
          uploadController.description.text,
          uploadController.titre.text,
          uploadController.texte.text,
          uploadController.regionChoix,
          uploadController.filepath,
          1);
      Get.back();
      if (res[0]) {
        Timer(Duration(seconds: 2), () {
          btnController.reset();
        });
        btnController.success();
        Get.snackbar(
          "Ajout",
          "Le contenue a bien été ajoutée.",
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.grey,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          duration: Duration(seconds: 2),
        );
        return true;
      } else {
        btnController.reset();
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
        return false;
      }
    } catch (err) {
      print("4---: $err");
      Get.back();
      Get.snackbar(
        "Erreur",
        "Vérfier votre connexion Internet.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.red,
        borderRadius: 10,
        borderWidth: 2,
        barBlur: 0,
        duration: Duration(seconds: 2),
      );
      return false;
    }
  }

  // *****************************************
  // HOME
}
