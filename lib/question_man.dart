// ignore_for_file: library_private_types_in_public_api

import 'dart:core';
//import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'player_man.dart';

class Question {
  int? id;
  String? question;
  int? gender;
  int? used;
  int? lvl;

  Question(this.id, this.question, this.gender, this.used, this.lvl);
}

class Data {
  late List<dynamic> truths;
  late List<dynamic> dares;

  _Data() {
    truths = [];
    dares = [];
  }
}

Question getQfJ(Map<String, dynamic> json) {
  Question q = Question(-1, '', 0, 0, 0);
  q.id = json['id'];
  q.question = json['question'];
  q.gender = json['gender'];
  q.used = json['used'];
  q.lvl = json['lvl'];
  return q;
}

Data d = Data();

Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/questions.json');
  final data = await json.decode(response);
  d.truths = data["truths"];
  d.dares = data["dares"];
}

Data getData() {
  if (d.truths.isEmpty || d.dares.isEmpty) {
    readJson();
  }
  return d;
}

Question getRandomQuestion(int params, Player p) {
  if (params == 0) {
    Question q = getQfJ(getData().truths[Random().nextInt(d.truths.length)]);
    int c = 0;
    while (q.gender != p.gender || q.used == 1) {
      q = getQfJ(getData().truths[Random().nextInt(d.truths.length)]);
      c++;
      if (c > 10) {
        return Question(-1, 'No more questions', 0, 0, 0);
      }
    }
    q.used = 1;
    return q;
  } else {
    Question q = getQfJ(getData().dares[Random().nextInt(d.dares.length)]);
    int c = 0;
    while (q.gender != p.gender || q.used == 1) {
      q = getQfJ(getData().dares[Random().nextInt(d.dares.length)]);
      c++;
      if (c > 10) {
        return Question(-1, 'No more questions', 0, 0, 0);
      }
    }
    q.used = 1;
    return q;
  }
}
