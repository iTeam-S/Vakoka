import 'package:flutter/cupertino.dart';
import 'package:mybn/Models/speciality.dart';
import 'package:flutter/material.dart';

List<SpecialityModel> getSpeciality() {
  List<SpecialityModel> specialities =
      new List<SpecialityModel>.empty(growable: true);
  SpecialityModel specialityModel = new SpecialityModel();

  //1
  specialityModel.noOfDoctors = 5;
  specialityModel.speciality = "Medecine Traditionnel";
  specialityModel.imgAssetPath = "assets/img/pervenche.jpg";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();
  //2
  specialityModel.noOfDoctors = 10;
  specialityModel.speciality = "  Zavamaniry";
  specialityModel.imgAssetPath = "assets/img/baobab.jpg";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();
  //3
  specialityModel.noOfDoctors = 16;
  specialityModel.speciality = "Arlème";
  specialityModel.imgAssetPath = "assets/img/gidro.jpg";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  return specialities;
}

List<AuteurModel> getAuteur() {
  List<AuteurModel> lauteurs = new List<AuteurModel>.empty(growable: true);
  AuteurModel auteurModel = new AuteurModel();

  //1
  auteurModel.validite = false;
  auteurModel.speciality = "Ody gasy,Culturisme,Biby, Ravinkazo";
  auteurModel.imgAssetPath = "assets/img/doc.png";
  auteurModel.name = "Soa Lahy";
  lauteurs.add(auteurModel);
  auteurModel = new AuteurModel();

  //2
  auteurModel.validite = true;
  auteurModel.speciality = "Ody gasy,Culturisme,Biby, Ravinkazo";
  auteurModel.imgAssetPath = "assets/img/doc.png";
  auteurModel.name = "Rabe San";
  lauteurs.add(auteurModel);
  auteurModel = new AuteurModel();

  //3
  auteurModel.validite = true;
  auteurModel.speciality = "Ody gasy,Culturisme,Biby, Ravinkazo";
  auteurModel.imgAssetPath = "assets/img/doc.png";
  auteurModel.name = "Rabe Kot";
  lauteurs.add(auteurModel);
  auteurModel = new AuteurModel();

  //4
  auteurModel.validite = false;
  auteurModel.speciality = "Ody gasy,Culturisme,Biby, Ravinkazo";
  auteurModel.imgAssetPath = "assets/img/img1.png";
  auteurModel.name = "Rabe";
  lauteurs.add(auteurModel);
  auteurModel = new AuteurModel();

  return lauteurs;
}
