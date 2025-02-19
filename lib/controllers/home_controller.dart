import 'package:get/get.dart';

class HomeController extends GetxController {
  List<int> indexList = [];

  addIndex(value) {
    indexList.add(value);
    update();
  }
}
