// ignore_for_file: library_private_types_in_public_api

import 'dart:core';
//import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:truth_dare/main.dart';
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

  static void addQuestion(String q, int g, String type) {
    if (type == 'Truth') {
      MyApp.d.truths.add(Question(
          MyApp.d.truths.length + 1, q, g, 0, Random().nextInt(3) + 1));
    } else {
      MyApp.d.dares.add(
          Question(MyApp.d.dares.length + 1, q, g, 0, Random().nextInt(3) + 1));
    }
  }
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
  readJson();
  d = d;
  return d;
}

Question getRandomQuestion(int params, Player p, int counter) {
  List saet = [];
  //Data data = MyApp.d;
  counter++;
  if (params == 0) {
    saet = MyApp.d.truths;
  }
  if (params == 1) {
    saet = MyApp.d.dares;
  }

  int i = Random().nextInt(saet.length);
  Question q = saet[i];
  int? c = params * 100 + q.id!;

  if (counter > 100) {
    return Question(
        -1, 'Sorry to Hard to find something for You, ${q.question}', 0, 0, 0);
  }
  if (p.questions.contains(c)) {
    return getRandomQuestion(params, p, counter);
  }

  if (q.gender != p.gender) {
    if (q.gender != 0) {
      return getRandomQuestion(params, p, counter);
    }
  }
  if (params == 0) {
    MyApp.d.truths[i].used = 1;
  }
  if (params == 1) {
    MyApp.d.dares[i].used = 1;
  }
  p.gotQuestion(c);
  return q;
}
