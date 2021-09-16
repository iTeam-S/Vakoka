import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:mybn/controllers/upload.dart';

const String BaseUrl = "192.168.137.1:4444";
const String BaseUrlProtocol = 'http://' + BaseUrl;

class ApiController extends GetxController {
  var client = dio.Dio(dio.BaseOptions(
    baseUrl: "$BaseUrlProtocol",
  ));
  final UploadController uploadController = Get.put(UploadController());

  Future<List> login(usr, passwd) async {
    try {
      var response = await client.post(
        "/api/v1/login/",
        data: {"mail": usr, "password": passwd},
      );
      return [true, response.data];
    } on dio.DioError catch (err) {
      if (err.response!.statusCode == 403) {
        return [false, err.response!.data['status']];
      } else {
        return [false, err.message];
      }
    } catch (e) {
      print(e);
      return [false, "Verifier Votre Réseau"];
    }
  }

  Future<List> uploadContent(
      int userid,
      String token,
      String desc,
      String titre,
      String texte,
      String region,
      String filepath,
      int categories) async {
    try {
      List filetmp = filepath.split('/');
      String filename = filetmp[filetmp.length - 1];
      var formData = dio.FormData.fromMap({
        'user_id': userid,
        'token': token,
        'description': desc,
        'title': titre,
        'texte': texte,
        'region': region,
        'categorie_ids': categories,
        'files': await dio.MultipartFile.fromFile(filepath, filename: filename),
      });
      var response = await client.post(
        '/api/v1/insert_content/',
        data: formData,
        onSendProgress: (int sent, int total) {
          print(uploadController.uploadPourcent);
          uploadController.uploadPourcent = sent / total;
          uploadController.update();
        },
      );
      return [true, response.data];
    } on dio.DioError catch (err) {
      if (err.response!.statusCode == 403) {
        return [false, err.response!.data['status']];
      } else {
        return [false, err.response!.data['status']];
      }
    } catch (e) {
      print("8---: $e");
      return [false, "Verifier Votre Réseau"];
    }
  }

  Future<List> getcontent(int userid, String token) async {
    try {
      var response = await client.post(
        "/api/v1/get_content/",
        data: {"user_id": userid, "token": token},
      );
      return [true, response.data];
    } on dio.DioError catch (err) {
      print(err);
      if (err.response!.statusCode == 403) {
        Timer(Duration(seconds: 2), () {
          // Session expiré ==> reconnexion
          Get.offNamed('/login');
        });
        return [false, err.response!.data['status']];
      } else {
        return [false, err.response!.data['status']];
      }
    } catch (e) {
      print(e);
      return [false, "Verifier Votre Réseau"];
    }
  }
}
