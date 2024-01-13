class Friend {
  late String guess_uid;
  late String yerel_uid;
  late String room_name;
  late List messages;
  Friend(this.guess_uid, this.yerel_uid, this.room_name);
  factory Friend.fromJson(Map<dynamic, dynamic> map) {
    return Friend(map["guess_uid"], map["yerel_uid"], map["room_name"]);
  }
}
