class Users {
  String key;
  String uid;
  String name;
  Users(this.key, this.uid, this.name);
  factory Users.fromJson(String key, Map<dynamic, dynamic> data) {
    return Users(key,data["uid"],data["name"]);
  }
}
