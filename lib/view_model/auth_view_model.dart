import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  final _firebaseAuth = FirebaseAuth.instance;

  String email = "", password = "", name = "";

  // ignore: prefer_final_fields
  Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_firebaseAuth.authStateChanges());
  }

  void signup() {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  void login() {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  void logout() {}
}
