import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:successquiz/pages/quiz_page.dart';
import 'package:successquiz/utils/constants.dart';
import '../../controller/quiz_controller.dart';
import '../../models/quiz_category.dart';

class QuizCategoryCard extends StatelessWidget {
  final image;
  final QuizCategory category;
  const QuizCategoryCard(
    this.category, {
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.find<QuizController>().loadQuestions(category);
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, anim, anim2) => FadeTransition(
              opacity: anim,
              child: QuizPage(),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            child: SingleChildScrollView(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/" + image + ".png",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 25,
                      padding: EdgeInsets.only(left: 16, top: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.black),
                      child: Text(
                        category.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
