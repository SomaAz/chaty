import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changePage(int i) {
    _currentIndex = i;
    update();
  }
}
