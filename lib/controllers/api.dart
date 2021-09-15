import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

const String BaseUrl = "192.168.137.1:4444";
const String BaseUrlProtocol = 'http://' + BaseUrl;

class ApiController extends GetxController {
  var client = dio.Dio(dio.BaseOptions(
    baseUrl: "$BaseUrlProtocol",
  ));

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
}
