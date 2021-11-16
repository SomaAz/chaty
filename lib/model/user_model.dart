class UserModel {
  final String name;
  final String uid;
  final String email;
  final String image;

  UserModel({
    required this.name,
    required this.uid,
    required this.email,
    this.image = "",
  });
}
