// ~ This class contains the information of the user while he navigates between
// ~ different screen of our app

class AppUser {
  final String uid;
  String username;
  String email;
  String avatar;
  int level;

  AppUser({required this.uid, required this.username, required this.email, required this.avatar, required this.level});
}
