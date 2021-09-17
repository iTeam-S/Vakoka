import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mybn/controllers/api.dart';
import 'package:mybn/controllers/upload.dart';
import 'package:mybn/models/contenue.dart';
import 'package:mybn/models/users.dart';
import 'package:mybn/translation.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppController extends GetxController {
  final ApiController apiController = Get.put(ApiController());
  final UploadController uploadController = Get.put(UploadController());
  final box = GetStorage();
  late Contenue currentContenue;
  // ************* LOGIN *********************
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController queryController = TextEditingController();
  String selectedCategorie = 'Tous';
  // Utilisateur
  late User user;
  String lang = 'fr';
  List<Categorie> data = <Categorie>[];

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

  void init() async {
    try {
      var res = await apiController.getcontent(user.id, user.token);
      if (res[0]) {
        box.write('data', res[1]);
        box.save();
        data.clear();
        for (Map cat in res[1]) {
          List<Contenue> contTmp = <Contenue>[];
          for (Map cont in cat['contents'])
            contTmp.add(Contenue(
                cont['id'],
                cont['title'],
                cont['description'],
                cont['text'],
                Profile(cont['nom'], cont['user_badge'] == 1 ? true : false),
                cont['badge'] == 1 ? true : false,
                cont['files'],
                cont['region']));
          Categorie catTmp = Categorie(cat['cat_id'], cat['cat_name'], contTmp);
          data.add(catTmp);
        }
      }
    } catch (err) {
      if (box.hasData('data')) {
        var res = box.read('data');
        Get.snackbar(
          "Attention",
          "Vous êtes hors ligne.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.red,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          duration: Duration(seconds: 5),
        );
        for (Map cat in res) {
          List<Contenue> contTmp = <Contenue>[];
          for (Map cont in cat['contents'])
            contTmp.add(Contenue(
                cont['id'],
                cont['title'],
                cont['description'],
                cont['text'],
                Profile(cont['nom'], cont['user_badge'] == 1 ? true : false),
                cont['badge'] == 1 ? true : false,
                cont['files'],
                cont['region']));
          Categorie catTmp = Categorie(cat['cat_id'], cat['cat_name'], contTmp);
          data.add(catTmp);
        }
      }
    }
    update();
  }

  List<String> getCategories() {
    List<String> res = <String>['Tous'];
    for (Categorie cat in data) res.add(cat.nom);

    return res;
  }

  List<Contenue> getContenues(String selectedCategorie) {
    List<Contenue> res = [];
    for (Categorie cat in data)
      if (selectedCategorie == cat.nom)
        return cat.contenues;
      else if (selectedCategorie == 'Tous')
        for (Contenue cont in cat.contenues) res.add(cont);
      else if (selectedCategorie == 'search') {
        for (Contenue cont in cat.contenues)
          if (cont.titre
                  .toLowerCase()
                  .contains(queryController.text.toLowerCase()) ||
              cont.description
                  .toLowerCase()
                  .contains(queryController.text.toLowerCase())) res.add(cont);
      } else if (selectedCategorie.contains('_REGION_')) {
        String region = selectedCategorie.replaceAll('_REGION_', '');
        for (Contenue cont in cat.contenues) {
          if (region == cont.region) res.add(cont);
        }
      }
    return res;
  }

  void search(String text) {
    selectedCategorie = 'search';
    update();
  }

  // *****************************************
  // HOME
}
