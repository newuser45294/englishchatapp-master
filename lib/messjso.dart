class Messager {
  String message;
  Messager(this.message);
  factory Messager.fromJson(Map<dynamic, dynamic> map) {
    return Messager(map["message"]);
  }
}
