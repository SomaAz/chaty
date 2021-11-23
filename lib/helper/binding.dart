import 'package:chaty/view_model/auth_view_model.dart';
import 'package:chaty/view_model/home_view_model.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
    // Get.lazyPut(() => PeopleViewModel());
  }
}
