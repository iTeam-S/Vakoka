import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class NavCtrl extends GetxController {
  RxInt _indexSelectionee = 0.obs;

  int get indexSelectionee => _indexSelectionee.value;

  List<String> get navItems => ['Home', 'About', 'Contact', 'Project'];

  void setNavIndex(int index) {
    _indexSelectionee.value = index;
  }
}

/*

class ListeCateg extends GetxController {
  RxInt _categSelectionee = 0.obs;

  int get categSelectionee => _categSelectionee.value;

  List<String> get categories => ['Home', 'About', 'Contact', 'Project'];

  void setListeIndex(int index) {
    _categSelectionee.value = index;
  }
}

*/
