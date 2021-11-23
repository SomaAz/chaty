import 'package:chaty/model/user_model.dart';
import 'package:chaty/view/chat_view.dart';
import 'package:get/get.dart';

class PeopleViewModel extends GetxController {
  void navigateToChatRoom(UserModel user, UserModel thisUserModel) async {
    Get.to(() => ChatView(thisUserModel, user));
  }
}
