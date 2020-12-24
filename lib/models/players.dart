import 'dart:convert';

import 'package:http/http.dart';

class Players {
  int charId;
  String name;
  String birthday;

  String img;
  String status;
  String nickname;
  
  String portrayed;
  String category;

  Players({
    this.charId,
    this.name,
    this.birthday,
    this.img,
    this.status,
    this.nickname,
    
    this.portrayed,
    this.category,
  });

  Players.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    
    portrayed = json['portrayed'];
    category = json['category'];
  }
}

class PlayersList {
  List<Players> player;
  PlayersList({this.player});

  factory PlayersList.fromjson(List<dynamic> parsedjson) {
    List<Players> player = List<Players>();

    player = parsedjson.map((e) => Players.fromJson(e)).toList();
    return PlayersList(player: player);
  }
}

class NetworkHelper {
  final String ur;

  NetworkHelper(this.ur);

  Future<PlayersList> getPlayers() async {
    final response = await get(Uri.encodeFull(ur));

    if (response.statusCode == 200) {
      print(response.body);
      //OK
      return PlayersList.fromjson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load');
    }
  }
}
