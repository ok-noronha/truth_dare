// ignore_for_file: library_private_types_in_public_api

import 'dart:core';
//import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
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
  late List<Question> truths;
  late List<Question> dares;

  Data() {
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
//List<Question> _truths = [];
//List<Question> _dares = [];

Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/questions.json');
  final data = await json.decode(response);
  d.truths = [for (var x in data["truths"]) getQfJ(x)];
  d.dares = [for (var x in data["dares"]) getQfJ(x)];
}

Data getData() {
  if (d.truths.isEmpty || d.dares.isEmpty) {
    readJson();
  }
  d = d;
  return d;
}

Question getRandomQuestion(int params, Player p, int counter) {
  List saet = [];
  counter++;
  if (counter > 100) {
    return Question(-1, 'Sorry to Hard to find something for You', 0, 0, 0);
  }
  if (params == 0) {
    saet = d.truths;
  }
  if (params == 1) {
    saet = d.dares;
  }
  int i = Random().nextInt(saet.length);
  Question q = saet[i];
  if (q.used == 1) {
    if (p.questions.contains(q.id)) {
      return getRandomQuestion(params, p, counter);
    }
  }
  if (q.gender != p.gender) {
    if (q.gender != 0) {
      return getRandomQuestion(params, p, counter);
    }
  }
  if (params == 0) {
    d.truths[i].used = 1;
  }
  if (params == 1) {
    d.dares[i].used = 1;
  }
  p.gotQuestion(q.id);
  return q;
}
