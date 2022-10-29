import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:successquiz/pages/home.dart';
import 'package:successquiz/utils/constants.dart';
import '../controller/quiz_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  PageController questionsPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: Obx(() {
          if (Get.find<QuizController>().loadingQuestions.value) {
            return Center(
                child: CircularProgressIndicator(
              color: purple1,
            ));
          }
          var questions = Get.find<QuizController>().questions;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PageView.builder(
              controller: questionsPageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (_, index) {
                var randQuestions = [
                  questions[index]["correct_answer"],
                  ...questions[index]["incorrect_answers"],
                ];
                randQuestions.shuffle();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Questions ${index + 1}/${questions.length}",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${Get.find<QuizController>().points} points",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white70),
                      child: Text(
                        questions[index]["question"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                          randQuestions.length,
                          (index2) => Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: purple1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (questions[index]["correct_answer"] ==
                                          randQuestions[index2]) {
                                        Get.find<QuizController>()
                                                .score
                                                .value +=
                                            Get.find<QuizController>().points;
                                        print(Get.find<QuizController>()
                                            .score
                                            .value);

                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            shape: CircleBorder(),
                                            content: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image.asset(
                                                "assets/images/correct.png",
                                              ),
                                            ),
                                          ),
                                        );

                                        Fluttertoast.showToast(
                                          msg: "Correct",
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.green,
                                          fontSize: 20,
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            shape: CircleBorder(),
                                            content: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image.asset(
                                                "assets/images/wrong.png",
                                              ),
                                            ),
                                          ),
                                        );
                                        Fluttertoast.showToast(
                                          msg:
                                              "Correct answer is : ${questions[index]["correct_answer"]}",
                                          gravity: ToastGravity.BOTTOM,
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.red,
                                          fontSize: 20,
                                        );
                                      }
                                      randQuestions.clear();
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      child: Text(
                                        randQuestions[index2],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: index + 1 == questions.length
                                  ? () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text(
                                            "Congratulations",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          content: Text(
                                            "Your Score is :\t${Get.find<QuizController>().score.value}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: purple1),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                randQuestions.shuffle();
                                                Get.find<QuizController>()
                                                    .score(0);
                                                questionsPageController
                                                    .animateToPage(
                                                  0,
                                                  duration: Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  curve: Curves.linear,
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Retry",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: purple1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  : () {
                                      questionsPageController.nextPage(
                                          duration: Duration(milliseconds: 250),
                                          curve: Curves.linear);
                                    },
                              child: Text(
                                  index + 1 == questions.length
                                      ? "See Result"
                                      : "Next Question",
                                  style:
                                      TextStyle(color: purple1, fontSize: 20)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox.shrink(),
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
