class User {
  final int id;
  String nom;
  String token;
  String admin;
  String email;
  User(
      {required this.id,
      required this.nom,
      required this.token,
      required this.email,
      required this.admin});
}
