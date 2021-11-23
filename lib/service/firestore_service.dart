import 'package:chaty/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addUserToFirestore(UserModel user) {
    try {
      _firestore.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'name': user.name,
        'email': user.email,
        'image': user.image,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot querySnapshot = await _firestore.collection("users").get();

    List<UserModel> list = querySnapshot.docs
        .map(
          (doc) => UserModel(
            name: doc["name"],
            uid: doc["uid"],
            email: doc["email"],
            image: doc["image"],
          ),
        )
        .toList();
    return list;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    return await _firestore.collection("users").doc(uid).get();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getChatRooms(
      List<UserModel> users) async {
    final snapshot = await _firestore.collection("chatRooms").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatRooms =
        snapshot.docs.where(
      (doc) {
        final List<dynamic> docUsersUids = doc.data()["users"] as List<dynamic>;
        final List<String> usersUids = users.map((e) => e.uid).toList();

        if (users.length == 1) {
          for (String docUsersUid in docUsersUids) {
            if (docUsersUid != usersUids.first) {
              return false;
            }
          }
        }

        if (usersUids.every((uid) => docUsersUids.contains(uid))) {
          return true;
        } else {
          return false;
        }
      },
    ).toList();
    return chatRooms;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRoomMessages(
      String chatRoomId) {
    return _firestore
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timeSent", descending: false)
        .snapshots();
  }

  void createChatRoom(List<UserModel> users) async {
    final DocumentReference<Map<String, dynamic>> doc =
        _firestore.collection("chatRooms").doc();
    await doc.set({
      "chatRoomId": doc.id,
      "timeCreated": Timestamp.now(),
      "users": users.map((e) => e.uid).toList(),
    });
  }

  Future<void> sendMessage(
      {required String sender,
      required String chatRoomId,
      required String text}) async {
    _firestore
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .add({
      "sender": sender,
      "text": text,
      "timeSent": Timestamp.now(),
    });
  }
}
