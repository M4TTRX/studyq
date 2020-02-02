import 'dart:convert';

class FriendScore {
  int highscore;
  String username;

  FriendScore({
    this.highscore,
    this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'highscore': highscore,
      'username': username,
    };
  }

  static FriendScore fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FriendScore(
      highscore: map['highscore'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  static FriendScore fromJson(String source) => fromMap(json.decode(source));
}
