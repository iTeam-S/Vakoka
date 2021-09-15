import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  double uploadPourcent = 0.0;
  String regionChoix = 'Régions';
  String categorie = 'Catégories';
  String filepath = '';
  TextEditingController titre = TextEditingController();
  TextEditingController filetitre = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController texte = TextEditingController();
  List<String> regions = [
    'Régions',
    "Alaotra Mangoro",
    "Amoron'i Mania",
    "Analamanga",
    "Androy",
    "Analanjirofo",
    "Anosy",
    "Atsinanana",
    "Atsimo-Atsinanana",
    "Atsimo-Andrefana",
    "Betsiboka",
    "Boeny",
    "Bongolava",
    "Diana",
    "Haute-Matsiatra",
    "Ihorombe",
    "Itasy",
    "Melaky",
    "Menabe",
    "Sava",
    "Sofia",
    "Vakinankaratra",
    "Vatovavy-Fitovinany"
  ];
}
