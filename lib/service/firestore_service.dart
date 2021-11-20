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
    return snapshot.docs.where(
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
  }

  void createChatRoom(List<UserModel> users) async {
    await _firestore.collection("chatRooms").add({
      "timeCreated": Timestamp.now(),
      "users": users.map((e) => e.uid).toList(),
    });
  }
}
