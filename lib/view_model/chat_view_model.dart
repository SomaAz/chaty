import 'package:chaty/model/user_model.dart';
import 'package:chaty/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatViewModel extends GetxController {
  UserModel thisUserModel;
  UserModel otherUserModel;
  ChatViewModel({
    required this.thisUserModel,
    required this.otherUserModel,
  });

  Future<Map<String, dynamic>> returnChatRoom() async {
    final bool sameUser = thisUserModel.uid == otherUserModel.uid;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatRooms =
        await FirestoreService().getChatRooms(
      sameUser ? [otherUserModel] : [otherUserModel, thisUserModel],
    );

    if (chatRooms.isEmpty) {
      print("Creating ChatRoom...");
      FirestoreService().createChatRoom([
        otherUserModel,
        thisUserModel,
      ]);
      chatRooms = await FirestoreService().getChatRooms(
        sameUser ? [otherUserModel] : [otherUserModel, thisUserModel],
      );
    }
    final chatRoom = chatRooms.map((e) => e.data()).toList().first;
    return chatRoom;
  }
}
