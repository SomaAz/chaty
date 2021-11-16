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
}
