import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:successquiz/pages/result.dart';
import '../models/quiz_category.dart';
import 'package:http/http.dart' as http;

class QuizController extends GetxController with SingleGetTickerProviderMixin {
  RxInt score = 0.obs;
  int points = 10;

  RxList categories = [
    QuizCategory(name: "C#", id: 1, difficulty: "Easy"),
    QuizCategory(name: "Ruby", id: 2, difficulty: "Medium"),
    QuizCategory(name: "Dart", id: 3, difficulty: "Easy"),
    QuizCategory(name: "Flutter", id: 4, difficulty: "Medium"),
    QuizCategory(name: "Java", id: 5, difficulty: "Easy"),
    QuizCategory(name: "JavaScript", id: 6, difficulty: "Medium"),
    QuizCategory(name: "Kotlin", id: 7, difficulty: "Easy"),
    QuizCategory(name: "Nodejs", id: 8, difficulty: "Medium"),
    QuizCategory(name: "PHP", id: 9, difficulty: "Easy"),
    QuizCategory(name: "Python", id: 10, difficulty: "Medium"),
  ].obs;

  RxList questions = [].obs;
  RxBool loadingQuestions = true.obs;

 // double get totalScore=>cardItems.fold(0,)

  loadQuestions(QuizCategory category) async {
    questions.clear();
    score(0);
    loadingQuestions(true);
    http.Response res = await http.get(Uri.parse(
        "https://opentdb.com/api.php?amount=15&category=18&difficulty=easy&type=multiple"
        //"https://opentdb.com/api.php?amount=20&category=18&difficulty=medium&type=multiple"
        ));

    var json = jsonDecode(res.body);
    if (json["results"] != null) {
      json["results"].forEach((e) => questions.add(e));
    }
    loadingQuestions(false);
  }

  clearQuestion() => questions.clear();
}
