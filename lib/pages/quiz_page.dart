import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:successquiz/pages/result.dart';
import 'package:successquiz/utils/constants.dart';
import '../controller/quiz_controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  PageController questionsPageController = PageController();
  bool isPress = false;
  Color isTrue = Colors.green;
  Color isFalse = Colors.red;
  Color bgColor = Colors.pinkAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                // gradient: LinearGradient(colors: [p1, purpled]),
                ),
          ),
          SafeArea(
            child: Obx(() {
              // if (Get.find<QuizController>().loadingQuestions.value)
              if (Get.put<QuizController>(QuizController())
                  .loadingQuestions
                  .value) {
                return Center(child: CircularProgressIndicator());
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
                    //print(randQuestions);

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
                                    // color: Colors.white,
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
                              thickness: 1.5,
                              color: blued,
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
                              // color: Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...List.generate(
                              randQuestions.length,
                              (index) => Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          elevation: 0,
                                          backgroundColor: purple1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (questions[index]
                                                  ["correct_answer"] ==
                                              randQuestions[index]) {
                                            setState(() {
                                             var _score= Get.find<QuizController>()
                                                      .score.value
                                                       +=
                                                  Get.find<QuizController>()
                                                      .points;
                                            });
                                          }
                                          var i = questionsPageController.page!
                                                  .round() +
                                              1;
                                          if (i >= questions.length) {
                                            
                                            Get.to(ScoreScreen());
                                          } else {
                                            questionsPageController
                                                .animateToPage(
                                              i,
                                              duration:
                                                  Duration(milliseconds: 250),
                                              curve: Curves.bounceIn,
                                            );
                                            randQuestions.clear();
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Text(
                                            randQuestions[index],
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
                              height: 60,
                            ),
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
        ],
      ),
    );
  }

  // ElevatedButton buildElevatedButton() {
  //   return ElevatedButton(onPressed: () {},
  //    child: Text(_questionNumber<questions.length? 'Next':"Resuit"));
  // }
}
