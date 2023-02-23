// ignore_for_file: unused_element
import 'dart:math';

class Player {
  int id;
  String name;
  int gender;
  num score = 0.0;
  List<int?> questions = [];
  Player(this.id, this.name, this.gender);

  void gotQuestion(int? q) {
    findPlayer(id, _players).questions.add(q);
  }

  void addScore(num s) {
    findPlayer(id, _players).score += s;
  }

  static Player findPlayer(int id, List<Player> list) =>
      list.firstWhere((player) => player.id == id);

  static Player getPlayerObj() => Player(-1, '', 0);

  static Player gRP() => _players[Random().nextInt(_players.length)];
  static Player? getRandomPlayer() {
    if (_players.isEmpty) {
      return null;
    } else {
      return gRP();
    }
  }

  static void addPlayer(int i, String n, int g) {
    _players.add(Player(i, n, g));
  }

  static void removePlayer(int i) {
    _players.removeWhere((element) => element.id == i);
  }

  static List<Player> getPlayers() => _players;
}

List<Player> _players = [];
